//
//  MealPlanAPI.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/28/22.
//

import Foundation
import Alamofire

class MealPlanManager {
    
    static func fetchMealPlan(mealReqs: AllMealReqs, completion: @escaping (([MealInfo]) -> Void)) {
        
        var mealPlan = [MealInfo]()
        
        // TODO: is this code best practice? post on stackoverflow, is it concurrent threading?
        // https://betterprogramming.pub/a-deep-dive-into-dispatch-groups-8251bbb8b001 (avoid using wait or put timeout)
        DispatchQueue.global().async {
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.fetchMealBasedOn(mealReqs.breakfast) { mealInfo in
                if let mealInfo = mealInfo {
                    mealPlan.append(mealInfo)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            self.fetchMealBasedOn(mealReqs.lunch) { mealInfo in
                if let mealInfo = mealInfo {
                    mealPlan.append(mealInfo)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            self.fetchMealBasedOn(mealReqs.dinner) { mealInfo in
                if let mealInfo = mealInfo {
                    mealPlan.append(mealInfo)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
            dispatchGroup.notify(queue: .main) {
                completion(mealPlan)
            }
        }
    }
    
    static func fetchMealBasedOn(_ req: MealReq, completion: @escaping ((MealInfo?) -> Void)) {
        print("running fetch meal")
        
        // Validate appId and appKey
        guard let appId = Bundle.main.infoDictionary?["edamam_app_id"] as? String,
              let appKey = Bundle.main.infoDictionary?["edamam_app_key"] as? String else { return }

        // Create urlPrefix with queryItems
        var urlPrefix = URLComponents(string: "https://api.edamam.com/api/recipes/v2")!
        let queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "q", value: req.type),
            URLQueryItem(name: "app_id", value: appId),
            URLQueryItem(name: "app_key", value: appKey),
            URLQueryItem(name: "mealType", value: req.type),
            URLQueryItem(name: "calories", value: req.macros.calories),
            URLQueryItem(name: "imageSize", value: "REGULAR"),
            URLQueryItem(name: "random", value: "\(req.random)"),
            URLQueryItem(name: "nutrients[CHOCDF]", value: req.macros.carbs),
            URLQueryItem(name: "nutrients[FAT]", value: req.macros.fat),
            URLQueryItem(name: "nutrients[PROCNT]", value: req.macros.protein),
            URLQueryItem(name: "field", value: "label"),
            URLQueryItem(name: "field", value: "image"),
            URLQueryItem(name: "field", value: "images"),
            URLQueryItem(name: "field", value: "url"),
            URLQueryItem(name: "field", value: "shareAs"),
            URLQueryItem(name: "field", value: "yield"),
            URLQueryItem(name: "field", value: "dietLabels"),
            URLQueryItem(name: "field", value: "healthLabels"),
            URLQueryItem(name: "field", value: "ingredientLines"),
            URLQueryItem(name: "field", value: "ingredients"),
            URLQueryItem(name: "field", value: "calories"),
            URLQueryItem(name: "field", value: req.type),
            URLQueryItem(name: "field", value: "totalNutrients")
        ]
        urlPrefix.queryItems = queryItems
        urlPrefix.percentEncodedQuery = urlPrefix.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        // Create urlRequest
        var urlRequest = URLRequest(url: urlPrefix.url!)
        urlRequest.httpMethod = "GET"
        
        // Create URLSession dataTask with urlRequest
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print("Check internet connection: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MealData.self, from: data)
                guard let hits = result.hits else {
                    print("error: no hits based on meal reqs")
                    self.getMealDataBasedOnPriorities(reqs: req)
                    return
                }
                
                guard let recipe = hits[0].recipe, recipe.yield != nil else {
                    print("error: no recipe or yield data found")
                    return
                }
                
                self.convertToMealInfo(result: result, req: req) { mealInfo in
                    completion(mealInfo)
                }
            } catch {
                print("Can't decode JSON data \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    static func getMealDataBasedOnPriorities(reqs: MealReq) {
        print("calculate based on priorities")
    }
    
    // MARK: - HELPER FUNCTIONS
    static func convertToMealInfo(result: MealData, req: MealReq, completion: @escaping (MealInfo) -> Void) {
        if let count = result.hits?.count,
           let recipe = result.hits?[0].recipe,
           let yieldInt = recipe.yield,
           let name = recipe.label,
           let image = recipe.images?.regular?.url ?? recipe.image,
           let ingredients = recipe.ingredientLines,
           let instructionsURL = recipe.shareAs,
           let totalCalories = recipe.calories,
           let totalCarbs = recipe.totalNutrients?["CHOCDF"]?.quantity,
           let totalProtein = recipe.totalNutrients?["PROCNT"]?.quantity,
           let totalFat = recipe.totalNutrients?["FAT"]?.quantity {
            
            let yield = Double(yieldInt)
            let calories = Utils.doubleToStr(totalCalories/yield)
            let carbs = Utils.doubleToStr(totalCarbs/yield)
            let protein = Utils.doubleToStr(totalProtein/yield)
            let fat = Utils.doubleToStr(totalFat/yield)
            
            let updatedName = updateName(name: name)
            let mealOrder = determineMealOrder(type: req.type)
            
            let parsedMeal = MealInfo(mealOrder: mealOrder, image: image,
                                      type: req.type, name: updatedName.capitalized,
                                      macros: Macros(calories: calories,
                                                             carbs: carbs,
                                                             protein: protein,
                                                             fat: fat),
                                      ingredients: ingredients,
                                      instructionsURL: instructionsURL)
            
            completion(parsedMeal)
        }
    }
    
    static func updateName(name: String) -> String {
        var filteredName = name
        let removeWords = ["recipes", "recipe", "Recipes", "Recipe"]
        let replaceWords = ["and", "And"]
        
        for word in removeWords {
            for word1 in replaceWords {
                if let range = filteredName.range(of: word) {
                    filteredName.removeSubrange(range)
                }
                
                if let _ = filteredName.range(of: word1) {
                    filteredName = filteredName.replacingOccurrences(of: word1, with: "&")
                }
            }
        }
        
        return filteredName
    }
    
    static func determineMealOrder(type: String) -> Int {
        var mealOrder = Int()
        
        if type == MealType.breakfast.rawValue {
            mealOrder = 0
        } else if type == MealType.lunch.rawValue {
            mealOrder = 1
        } else if type == MealType.dinner.rawValue {
            mealOrder = 2
        } else if type == "protein" {
            mealOrder = 3
        }
        
        return mealOrder
    }
}

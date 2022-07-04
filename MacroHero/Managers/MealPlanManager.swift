//
//  MealPlanAPI.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/28/22.
//

import Foundation
import UIKit

class MealPlanManager {
    
    static func fetchMealPlan(mealReqs: [MealReq], callBack: @escaping (([MealInfo]) -> Void)) {
        
        let dispatchGroup = DispatchGroup()
        var mealPlan = [MealInfo]()
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            mealReqs.forEach { req in
                dispatchGroup.enter()
                self.fetchMealBasedOn(req) { result in
                    if let result = result {
                        var mealInfo = result
                        self.loadImageURL(for: mealInfo) { image in
                            mealInfo.image = image
                            mealPlan.append(mealInfo)
                            dispatchGroup.leave()
                        }
                    } else {
                        dispatchGroup.leave()
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                callBack(mealPlan)
            }
        }
    }
    
    static func fetchMealBasedOn(_ req: MealReq, completion: @escaping ((MealInfo?) -> Void)) {
        print("running fetch meal")
        
        // Validate appId and appKey
        guard let appId = Bundle.main.infoDictionary?["edamam_app_id"] as? String,
              let appKey = Bundle.main.infoDictionary?["edamam_app_key"] as? String,
              let macroReq = req.macros else { return }
        
        // Create urlPrefix with queryItems
        var urlPrefix = URLComponents(string: "https://api.edamam.com/api/recipes/v2")!
        
        let queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "q", value: req.type),
            URLQueryItem(name: "app_id", value: appId),
            URLQueryItem(name: "app_key", value: appKey),
            URLQueryItem(name: "mealType", value: req.type),
            URLQueryItem(name: "calories", value: macroReq.calories),
            URLQueryItem(name: "imageSize", value: "REGULAR"),
            URLQueryItem(name: "random", value: "\(req.random)"),
            URLQueryItem(name: "nutrients[CHOCDF]", value: macroReq.carbs),
            URLQueryItem(name: "nutrients[FAT]", value: macroReq.fat),
            URLQueryItem(name: "nutrients[PROCNT]", value: macroReq.protein),
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
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                print("Error: No data")
                
                completion(nil)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let result = try? JSONDecoder().decode(MealData.self, from: data)
                
                // convert result (MealData) into MealInfo
                guard let hits = result?.hits, !hits.isEmpty else {
                    print("Error: No meals based on meal req")
                    // If no hits
                    completion(self.getMealDataBasedOnPriorities(req: req))
                    return
                }
                
                // TODO: select random hit index, does it need to be random bc of the GET call paramter?
//                let randomIndex = (0..<hits.count).randomElement() ?? 0
                
                // TODO: Update to find recipe and yield info from another MealData object, if nil
                guard let recipe = hits[0].recipe, recipe.yield != nil else {
                    print("Error: No recipe or yield data found in randomIndex, try another randomIndex")
                    completion(nil)
                    return
                }
                
                self.convertToMealInfo(recipe: recipe, req: req) { mealInfo in
                    completion(mealInfo)
                }
            } else {
                print("Error: No response")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    static func loadImageURL(for meal: MealInfo, completion: @escaping ((UIImage?) -> Void)) {
        print("fetching images")
        guard let imageURL = meal.imageURL, let url = URL(string: imageURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(Image.defaultMealImage)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let result = UIImage(data: data)
                completion(result ?? Image.defaultMealImage)
            }
        }
        
        task.resume()
    }
    
    
    static func getMealDataBasedOnPriorities(req: MealReq) -> MealInfo? {
        print("calculate based on priorities")
        return nil
    }
    
    // MARK: - HELPER FUNCTIONS
    static func convertToMealInfo(recipe: Recipe, req: MealReq,
                                  completion: @escaping (MealInfo?) -> Void) {
        if let yieldInt = recipe.yield,
           let name = recipe.label,
           let imageURL = recipe.images?.regular?.url ?? recipe.image,
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
            
            let mealInfo = MealInfo(mealOrder: mealOrder, imageURL: imageURL,
                                    type: req.type, name: updatedName.capitalized,
                                    macros: Macros(calories: calories,
                                                   carbs: carbs,
                                                   protein: protein,
                                                   fat: fat),
                                    ingredients: ingredients,
                                    instructionsURL: instructionsURL)
            
            completion(mealInfo)
        } else {
            completion(nil)
        }
    }
    
    static func updateName(name: String) -> String {
        var filteredName = name
        let removeWords = ["recipes", "recipe", "Recipes", "Recipe", "breakfast",
                           "Breakfast", "Lunch", "lunch", "Dinner", "dinner"]
        let replaceWords = [" and ", " And "]
        
        removeWords.forEach {
            if let range = filteredName.range(of: $0) {
                filteredName.removeSubrange(range)
            }
        }
        
        replaceWords.forEach {
            if let _ = filteredName.range(of: $0) {
                filteredName = filteredName.replacingOccurrences(of: $0, with: " & ")
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

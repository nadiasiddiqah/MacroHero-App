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
                    switch result {
                    case .success(let mealResult):
                        var mealInfo = mealResult
                        self.loadImage(for: mealInfo.imageURL ?? "") { image in
                            mealInfo.image = image
                            mealPlan.append(mealInfo)
                            dispatchGroup.leave()
                        }
                    case .failure(_):
                        dispatchGroup.leave()
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                callBack(mealPlan)
            }
        }
    }
    
    static func createGETMealRequest(_ req: MealReq) -> URLRequest? {
        // Validate appId and appKey
        guard let appId = Bundle.main.infoDictionary?["edamam_app_id"] as? String,
              let appKey = Bundle.main.infoDictionary?["edamam_app_key"] as? String,
              let macroReq = req.macros else { return nil }
        
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
        
        return urlRequest
    }
    
    static func fetchMealBasedOn(_ req: MealReq,
                                 completion: @escaping ((Result<MealInfo, APIError>) -> Void)) {
        print("running fetch meal")
        
        guard let urlRequest = createGETMealRequest(req) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Create URLSession dataTask with urlRequest
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let _ = error {
                completion(.failure(.dataTaskError))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponseStatus))
                return
            }

            guard let data = data else {
                completion(.failure(.corruptData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MealData.self, from: data)
            
                guard let hits = result.hits, !hits.isEmpty else {
                    let newResult = self.getMealDataBasedOnPriorities(req: req)
                    completion(newResult)
                    return
                }
                
                guard let recipe = hits[0].recipe, recipe.yield != nil else {
                    completion(.failure(.noRecipeOrYield))
                    return
                }
                
                self.convertToMealInfo(recipe: recipe, req: req) { parsedData in
                    switch parsedData {
                    case .success(let mealInfo):
                        completion(.success(mealInfo))
                    case .failure(_):
                        completion(.failure(.dataParsingError))
                    }
                }
                
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
    static func loadImage(for url: String, completion: @escaping ((UIImage) -> Void)) {
        print("fetching images")
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(Image.defaultMealImage!)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let result = UIImage(data: data)
                completion(result ?? Image.defaultMealImage!)
            }
        }
        
        task.resume()
    }
    
    
    static func getMealDataBasedOnPriorities(req: MealReq) -> (Result<MealInfo, APIError>) {
        print("calculate based on priorities")
        return .failure(.noHits)
    }
    
    // MARK: - HELPER FUNCTIONS
    static func convertToMealInfo(recipe: Recipe, req: MealReq,
                                  completion: @escaping (Result<MealInfo, APIError>) -> Void) {
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
            
            completion(.success(mealInfo))
        } else {
            completion(.failure(.dataParsingError))
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

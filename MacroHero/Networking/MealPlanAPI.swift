//
//  MealPlanAPI.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/28/22.
//

import Foundation
import Alamofire

class MealPlanAPI {
    
    static func fetchMealPlan(mealReqs: AllMealReqs, completion: @escaping (([MealInfo]) -> Void)) {
        
        var mealPlan = [MealInfo]()
        
        let breakfastReq = mealReqs.breakfast
        let lunchReq = mealReqs.lunch
        let dinnerReq = mealReqs.dinner
        
        #warning("TODO: is this code best practice? post on stackoverflow, is it concurrent threading?")
        // https://betterprogramming.pub/a-deep-dive-into-dispatch-groups-8251bbb8b001 (avoid using wait or put timeout)
        DispatchQueue.global().async {
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.fetchMealBasedOn(req: breakfastReq) { mealInfo in
                if let mealInfo = mealInfo {
                    mealPlan.append(mealInfo)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            self.fetchMealBasedOn(req: lunchReq) { mealInfo in
                if let mealInfo = mealInfo {
                    mealPlan.append(mealInfo)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            self.fetchMealBasedOn(req: dinnerReq) { mealInfo in
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
    
    static func fetchMealBasedOn(req: MealReq, completion: @escaping ((MealInfo?) -> Void)) {
        print("running fetch meal")
        
        guard let appId = Bundle.main.infoDictionary?["edamam_app_id"] as? String,
              let appKey = Bundle.main.infoDictionary?["edamam_app_key"] as? String else { return }
        
        AF.request("https://api.edamam.com/api/recipes/v2",
                   method: .get,
                   parameters: [
                    "type": "public",
                    "q": req.type,
                    "app_id": appId,
                    "app_key": appKey,
                    "mealType": req.type,
                    "calories": req.macros.calories,
                    "imageSize": ["REGULAR"],
                    "random": "\(req.random)",
                    "nutrients[CHOCDF]": req.macros.carbs,
                    "nutrients[FAT]": req.macros.fat,
                    "nutrients[PROCNT]": req.macros.protein,
                    "field": ["label", "image", "images", "url", "shareAs",
                              "yield", "dietLabels", "healthLabels", "ingredientLines",
                              "ingredients", "calories", req.type, "totalNutrients"]
                   ])
            .validate()
            .responseDecodable(of: MealData.self) { response in
                switch response.result {
                case let .success(data):
                    
                    guard !(data.hits?.isEmpty ?? true) else {
                        self.getMealDataBasedOnPriorities(reqs: req)
                        return
                    }
                    
                    guard let recipe = data.hits?[0].recipe, recipe.yield != nil else {
                        print("error: no recipe or yield data found")
                        return
                    }
                    
                    self.parseMealData(from: data, req: req) { parsedMeal in
                        completion(parsedMeal)
                    }
                case let .failure(error):
                    print("ERROR: \(error) \(error.localizedDescription)")
                }
            }
    }
    
    static func getMealDataBasedOnPriorities(reqs: MealReq) {
        print("calculate based on priorities")
    }
    
    // MARK: - HELPER FUNCTIONS
    static func parseMealData(from data: MealData, req: MealReq, completion: @escaping (MealInfo) -> Void) {
        if let count = data.hits?.count,
           let recipe = data.hits?[0].recipe,
           let yieldInt = recipe.yield,
           let name = recipe.label,
           let image = recipe.images?.regular?.url ?? recipe.image,
           let ingredients = recipe.ingredientLines,
           let instructions = recipe.shareAs,
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
                                      macros: MacroBreakdown(calories: calories,
                                                             carbs: carbs,
                                                             protein: protein,
                                                             fat: fat),
                                      ingredients: ingredients,
                                      instructions: [])
            
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

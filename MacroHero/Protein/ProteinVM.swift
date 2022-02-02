//
//  ProteinVM.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/19/22.
//

import Foundation
import Combine

#warning("generate mealPlan data during segue from Protein to Meal Plan screen, so when the data is all there, it can populate the Meal Plan screen immediately")
#warning("look into Alamofire for efficient HTTP networking")
class ProteinVM {
    @Published var mealPlan: MealPlan
    
    var breakfastData: MealInfo?
    var lunchData: MealInfo?
    var dinnerData: MealInfo?
    
//    var breakfastReq = MealReq(type: "breakfast",
//                               macros: MacroBreakdown(calories: "100+", carbs: "20+",
//                                                      protein: "15+", fat: "10+"),
//                               random: true,
//                               macroPriority: MacroPriority(macro1: "calories",
//                                                            macro2: "protein"))
//    var lunchReq = MealReq()
//    var dinnerReq = MealReq()
    
    init(mealPlan: MealPlan) {
        self.mealPlan = mealPlan
    }
    
    func getMealData(reqs: MealReq, completionHandler: @escaping (MealInfo) -> Void) {
        if let appId = Bundle.main.infoDictionary?["edamam_app_id"] as? String,
           let appKey = Bundle.main.infoDictionary?["edamam_app_key"] as? String {
            
            var apiPrefix = URLComponents(string: "https://api.edamam.com/api/recipes/v2")!
            
            guard let type = reqs.type, let macros = reqs.macros else { return }
            let queryItems = [
                URLQueryItem(name: "type", value: "public"),
                URLQueryItem(name: "q", value: type),
                URLQueryItem(name: "app_id", value: appId),
                URLQueryItem(name: "app_key", value: appKey),
                URLQueryItem(name: "mealType", value: type),
                URLQueryItem(name: "calories", value: macros.calories),
                URLQueryItem(name: "imageSize", value: "LARGE"),
                URLQueryItem(name: "imageSize", value: "REGULAR"),
                URLQueryItem(name: "random", value: "\(reqs.random)"),
                URLQueryItem(name: "nutrients[CHOCDF]", value: macros.carbs),
                URLQueryItem(name: "nutrients[FAT]", value: macros.fat),
                URLQueryItem(name: "nutrients[PROCNT]", value: macros.protein),
                URLQueryItem(name: "field", value: "uri"),
                URLQueryItem(name: "field", value: "label"),
                URLQueryItem(name: "field", value: "image"),
                URLQueryItem(name: "field", value: "images"),
                URLQueryItem(name: "field", value: "source"),
                URLQueryItem(name: "field", value: "url"),
                URLQueryItem(name: "field", value: "shareAs"),
                URLQueryItem(name: "field", value: "yield"),
                URLQueryItem(name: "field", value: "dietLabels"),
                URLQueryItem(name: "field", value: "healthLabels"),
                URLQueryItem(name: "field", value: "ingredientLines"),
                URLQueryItem(name: "field", value: "ingredients"),
                URLQueryItem(name: "field", value: "calories"),
                URLQueryItem(name: "field", value: "totalTime"),
                URLQueryItem(name: "field", value: "cuisineType"),
                URLQueryItem(name: "field", value: type),
                URLQueryItem(name: "field", value: "totalNutrients")
            ]
            apiPrefix.queryItems = queryItems
            apiPrefix.percentEncodedQuery = apiPrefix.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            apiPrefix.percentEncodedQuery = apiPrefix.percentEncodedQuery?.replacingOccurrences(of: "[", with: "%5B")
            apiPrefix.percentEncodedQuery = apiPrefix.percentEncodedQuery?.replacingOccurrences(of: "]", with: "%5D")
            let api = apiPrefix.url!
            
            let request = NSMutableURLRequest(url: api,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            print(request)
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
                guard let data = data, error == nil else {
                    print("Something went wrong")
                    return
                }
                
                var result: MealData?
                do {
                    result = try JSONDecoder().decode(MealData.self, from: data)
                } catch {
                    print("failed to convert \(error.localizedDescription)")
                }
                
                guard let json = result, !(json.hits?.isEmpty ?? true) else {
                    self.getMealDataBasedOnPriorities(reqs: reqs)
                    return
                }
                
                
                guard let recipe = json.hits?[0].recipe,
                      let yieldInt = recipe.yield else { return }
                
                if let count = json.count,
                   let name = recipe.label,
                   let image = recipe.image,
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
                    
                    self.mealPlan.breakfast = MealInfo(image: image,
                                                       type: type, name: name,
                                                       macros: MacroBreakdown(calories: calories,
                                                                              carbs: carbs,
                                                                              protein: protein,
                                                                              fat: fat),
                                                       ingredients: [],
                                                       instructions: [])
                    
                    print("count: \(count)")
                    print("name: \(name)")
                    print("yield: \(yield)")
                    print("thumbnail: \(image)")
                    print("instructions: \(instructions)")
                    print("ingredients: \(ingredients)")
//                    print("calories: \(Int(round(calories/yield)))")
//                    print("carbs: \(Int(round(carbs/yield)))")
//                    print("protein: \(Int(round(protein/yield)))")
//                    print("fat: \(Int(round(fat/yield)))")
                    
//                    DispatchQueue.main.async {
//                        completionHandler(MealInfo(image: thumbnail,
//                                                   type: reqs.type,
//                                                   name: name,
//                                                   macros: MacroBreakdown(calories: String(calories),
//                                                                          carbs: String(carbs),
//                                                                          protein: String(protein),
//                                                                          fat: String(fat)),
//                                                   ingredients: [],
//                                                   instructions: []))
//                    }
                    
                    
                    //                self?.vc?.breakfastData = MealInfo(image: thumbnail,
                    //                                               type: reqs.type,
                    //                                               name: name,
                    //                                               macros: MacroBreakdown(calories: String(calories),
                    //                                                                      carbs: String(carbs),
                    //                                                                      protein: String(protein),
                    //                                                                      fat: String(fat)),
                    //                                               ingredients: [],
                    //                                               instructions: [])
                    
                }
            }
            
            dataTask.resume()
        }
    }
    
    func getMealDataBasedOnPriorities(reqs: MealReq) {
        
    }
}

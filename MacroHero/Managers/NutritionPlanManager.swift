//
//  NutritionPlanManager.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/25/22.
//

import Foundation

class NutritionPlanManager {
    
    private init() {
    }
    
    var urlComponents: URLComponents {
        
    }
    
    func fetchNutritionPlan(for user: UserData,
                            completion: @escaping (Macros) -> Void ) {
            
            // Validate user data
            guard let age = user.age,
                  let sex = user.sex?.rawValue,
                  let height = user.heightCm,
                  let weight = user.weightKg,
                  let activity = user.activityLevel?.rawValue,
                  let goal = user.goal?.rawValue else { return }
            
            // Validate apiKey and url
            guard let apiKey = Bundle.main.infoDictionary?["macro_calculator_key"] as? String else { return }
            
            // Add query items to urlPrefix
            var urlPrefix = URLComponents(string: "https://fitness-calculator.p.rapidapi.com/macrocalculator")!
            let queryItems = [
                URLQueryItem(name: "age", value: age),
                URLQueryItem(name: "gender", value: sex),
                URLQueryItem(name: "height", value: height),
                URLQueryItem(name: "weight", value: weight),
                URLQueryItem(name: "activitylevel", value: activity),
                URLQueryItem(name: "goal", value: goal)
            ]
            urlPrefix.queryItems = queryItems
            
            // Create urlRequest from urlPrefix
            var urlRequest = URLRequest(url: urlPrefix.url!)
            urlRequest.httpMethod = "GET"
            urlRequest.headers = [
                "x-rapidapi-host": "fitness-calculator.p.rapidapi.com",
                "x-rapidapi-key": apiKey
            ]
            
            // Use URLSession to create dataTask object based on urlRequest
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    print("Data not fetched: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                // Decode data from JSON to MacroData (swift type)
                var result: MacroData?
                do {
                    result = try JSONDecoder().decode(MacroData.self, from: data)
                } catch {
                    print("Failed to convert JSON data: \(error.localizedDescription)")
                }
                
                guard let data = result?.data, let calories = data.calorie, let diet = data.balanced,
                      let carbs = diet.carbs, let protein = diet.protein, let fat = diet.fat else {
                    print("Failed to convert JSON data")
                    return
                }
                
                let macroPlan = Macros(calories: Utils.doubleToStr(calories), carbs: Utils.doubleToStr(carbs),
                                       protein: Utils.doubleToStr(protein), fat: Utils.doubleToStr(fat))
                
                DispatchQueue.main.async {
                    completion(macroPlan)
                }
            }
            
            task.resume()
            
            //            AF.request("https://fitness-calculator.p.rapidapi.com/macrocalculator",
            //                       method: .get,
            //                       parameters: [
            //                        "age": age,
            //                        "gender": sex,
            //                        "height": height,
            //                        "weight": weight,
            //                        "activitylevel": activity,
            //                        "goal": goal
            //                       ],
            //                       headers: [
            //                        "x-rapidapi-host": "fitness-calculator.p.rapidapi.com",
            //                        "x-rapidapi-key": apiKey
            //                       ])
            //            .validate()
            //            .responseDecodable(of: MacroData.self) { response in
            //                switch response.result {
            //                case let .success(macroData):
            //                    if let data = macroData.data,
            //                       let calories = data.calorie,
            //                       let diet = data.balanced,
            //                       let carbs = diet.carbs,
            //                       let protein = diet.protein,
            //                       let fat = diet.fat {
            //
            //                        let parsedDailyMacro = MacroPlan(
            //                            calories: Utils.doubleToStr(calories),
            //                            carbs: Utils.doubleToStr(carbs),
            //                            protein: Utils.doubleToStr(protein),
            //                            fat: Utils.doubleToStr(fat))
            //                        completion(parsedDailyMacro)
            //                    }
            //                case let .failure(error):
            //                    print("ERROR: \(error.localizedDescription)")
            //                }
            //            }
        }
    
}

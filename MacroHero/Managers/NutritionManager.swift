//
//  MacroCalculatorAPI.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/25/22.
//

import Foundation

class NutritionManager {
    
    static func fetchNutritionPlan(for user: UserData,
                                   completion: @escaping (Macros) -> Void ) {
        // Check required user parameters exist
        guard let age = user.age,
              let sex = user.sex?.rawValue,
              let height = user.heightCm,
              let weight = user.weightKg,
              let activity = user.activityLevel?.rawValue,
              let goal = user.goal?.rawValue else { return }
        
        // Check apiKey exists
        guard let apiKey = Bundle.main.infoDictionary?["macro_calculator_key"] as? String else { return }
        
        // Create urlPrefix with queryItems
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
        
        // Create urlRequest
        var urlRequest = URLRequest(url: urlPrefix.url!)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "x-rapidapi-host": "fitness-calculator.p.rapidapi.com",
            "x-rapidapi-key": apiKey
        ]
        
        // Create URLSession dataTask
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // Handle error
            guard let data = data, error == nil else {
                print("Check internet connection: \(error?.localizedDescription ?? "no error description")")
                return
            }
            
            // Decode JSON data into NutritionData
            do {
                let result = try JSONDecoder().decode(NutritionData.self, from: data)
                
                // Convert NutritionData to Macros
                guard let data = result.data, let cal = data.calorie, let diet = data.balanced,
                        let carbs = diet.carbs, let protein = diet.protein, let fat = diet.fat else {
                    print("Can't convert NutritionData to Macros")
                    return
                }
            
                let macros = Macros(calories: Utils.doubleToStr(cal), carbs: Utils.doubleToStr(carbs),
                                    protein: Utils.doubleToStr(protein), fat: Utils.doubleToStr(fat))
                
                DispatchQueue.main.async {
                    completion(macros)
                }
            } catch {
                print("Can't decode data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
}

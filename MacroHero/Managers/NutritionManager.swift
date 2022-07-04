//
//  MacroCalculatorAPI.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/25/22.
//

import Foundation

class NutritionManager {
    
    static func createGETMacrosRequest(for user: UserData) -> URLRequest? {
        // Check required user parameters exist
        guard let age = user.age,
              let sex = user.sex?.rawValue,
              let height = user.heightCm,
              let weight = user.weightKg,
              let activity = user.activityLevel?.rawValue,
              let goal = user.goal?.rawValue else { return nil }
        
        // Check apiKey exists
        guard let apiKey = Bundle.main.infoDictionary?["macro_calculator_key"] as? String else { return nil }
        
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
            "x-rapidapi-key": apiKey
        ]
        
        return urlRequest
    }
    
    static func fetchNutritionPlan(for user: UserData,
                                   completion: @escaping (Result<Macros, APIError>) -> Void ) {
        
        // Create GET URLRequest based on userInfo
        guard let urlRequest = createGETMacrosRequest(for: user) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Create URLSession dataTask
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // Handle error
            if let _ = error {
                completion(.failure(.dataTaskError))
            }
            
            // Check response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponseStatus))
                return
            }
            
            // Check data
            guard let data = data else {
                completion(.failure(.corruptData))
                return
            }
            
            // Decode JSON Response -> NutritionData (Swift response) -> Macros (Swift data object)
            do {
                let result = try JSONDecoder().decode(NutritionData.self, from: data)
                
                guard let data = result.data, let cal = data.calorie, let diet = data.balanced,
                        let carbs = diet.carbs, let protein = diet.protein, let fat = diet.fat else {
                    completion(.failure(.dataParsingError))
                    return
                }
            
                let macros = Macros(calories: Utils.doubleToStr(cal), carbs: Utils.doubleToStr(carbs),
                                    protein: Utils.doubleToStr(protein), fat: Utils.doubleToStr(fat))
                
                DispatchQueue.main.async {
                    completion(.success(macros))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
}

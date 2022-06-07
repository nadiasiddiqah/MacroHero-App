//
//  MacroCalculatorAPI.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 2/25/22.
//

import Foundation
import Alamofire

class MacroCalculatorAPI {
    
    static func fetchMacroData(
        for user: UserData,
        completion: @escaping (MacroPlan) -> Void ) {
            
            print("user: \(user)")
            
        guard let apiKey = Bundle.main.infoDictionary?["macro_calculator_key"] as? String else { return }
        guard let age = user.age,
              let sex = user.sex,
              let height = user.heightCm,
              let weight = user.weightKg,
              let activity = user.activityLevel?.rawValue,
              let goal = user.goal?.rawValue else { return }
            
            print(age)
            print(sex)
            print(height)
            print(weight)
            print(activity)
            print(goal)
        
        AF.request("https://fitness-calculator.p.rapidapi.com/macrocalculator",
                   method: .get,
                   parameters: [
                    "age": age,
                    "gender": sex,
                    "height": height,
                    "weight": weight,
                    "activitylevel": activity,
                    "goal": goal
                   ],
                   headers: [
                    "x-rapidapi-host": "fitness-calculator.p.rapidapi.com",
                    "x-rapidapi-key": apiKey
                   ])
        .validate()
        .responseDecodable(of: MacroData.self) { response in
            switch response.result {
            case let .success(macroData):
                if let data = macroData.data,
                   let calories = data.calorie,
                   let diet = data.balanced,
                   let carbs = diet.carbs,
                   let protein = diet.protein,
                   let fat = diet.fat {
                    
                    let parsedDailyMacro = MacroPlan(
                        calories: Utils.doubleToStr(calories),
                        carbs: Utils.doubleToStr(carbs),
                        protein: Utils.doubleToStr(protein),
                        fat: Utils.doubleToStr(fat))
                    completion(parsedDailyMacro)
                }
            case let .failure(error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
}

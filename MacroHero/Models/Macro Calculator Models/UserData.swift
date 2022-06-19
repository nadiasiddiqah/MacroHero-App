//
//  UserData.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/18/22.
//

import Foundation

struct UserData {
    var age, heightCm, weightKg: String?
    var sex: Sex?
    var activityLevel: Activity?
    var goal: Goal?
    var macroPlan: MacroPlan?
    var mealPlan: [MealInfo]?
}

struct MacroPlan {
    var calories, carbs, protein, fat: String
}

enum Sex: String {
    case male, female
}

enum Goal: String {
    case lose = "weightlose"
    case gain = "weightGain"
    case maintain 
}

enum Activity: String {
    case noExercise = "1"
    case lightExercise = "2"
    case moderateExercise = "3"
    case hardExercise = "4"
}

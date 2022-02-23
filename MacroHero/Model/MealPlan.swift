//
//  MealPlan.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/19/22.
//

import Foundation

struct MealInfo {
    var mealOrder: Int
    var image, type, name: String?
    var macros: MacroBreakdown?
    var ingredients, instructions: [String]?
}

struct MacroBreakdown {
    var calories, carbs, protein, fat: String
}



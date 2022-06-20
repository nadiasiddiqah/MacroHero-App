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
    var macros: MacroPlan?
    var ingredients, instructions: [String]?
    var isFavorite: Bool? = false
}


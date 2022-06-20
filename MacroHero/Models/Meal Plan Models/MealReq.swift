//
//  MealReq.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/14/22.
//

import Foundation

struct AllMealReqs {
    var breakfast: MealReq
    var lunch: MealReq
    var dinner: MealReq
}

struct MealReq {
    var type: String
    var macros: Macros
    var random: Bool = false
    var macroPriority: MacroPriority?
}

struct MacroPriority {
    var macro1: String
    var macro2: String
}


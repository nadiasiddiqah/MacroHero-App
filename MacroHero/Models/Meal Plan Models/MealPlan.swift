//
//  MealPlan.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/19/22.
//

import Foundation
import UIKit

struct MealInfo {
    var mealOrder: Int
    var image: UIImage?
    var imageURL, type, name: String?
    var macros: Macros?
    var ingredients: [String]?
    var instructionsURL: String?
    var isFavorite: Bool? = false
}

struct MealReq {
    var type: String
    var macros: Macros?
    var random: Bool = false
    var macroPriority: String?
}

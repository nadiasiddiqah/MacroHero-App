//
//  MealCellModel.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 6/15/22.
//

import Foundation

struct MealCellModel {
    var mealInfo: MealInfo
    var refreshAction: () -> Void
    var starButtonAction: () -> Void
}

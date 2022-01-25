//
//  MealDetailsVM.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/20/22.
//

import Foundation
import Combine

class MealDetailsVM {
    @Published var mealInfo: MealInfo
    
    init(mealInfo: MealInfo) {
        self.mealInfo = mealInfo
    }
}

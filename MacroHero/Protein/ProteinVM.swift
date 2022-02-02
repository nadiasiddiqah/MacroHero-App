//
//  ProteinVM.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/19/22.
//

import Foundation
import Combine

class ProteinVM {
    @Published var mealPlan: MealPlan
    
    init(mealPlan: MealPlan) {
        self.mealPlan = mealPlan
    }
}

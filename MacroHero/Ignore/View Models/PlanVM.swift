//
//  PlanVM.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/18/22.
//

import Foundation
import Combine

class PlanVM {
    @Published var dailyMacro: Macros
    
    init(dailyMacro: Macros) {
        self.dailyMacro = dailyMacro
    }
}

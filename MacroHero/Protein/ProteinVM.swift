//
//  ProteinVM.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/19/22.
//

import Foundation
import Combine

class ProteinVM {
    @Published var dailyMacro: MacroBreakdown
    
    init(dailyMacro: MacroBreakdown) {
        self.dailyMacro = dailyMacro
    }
}

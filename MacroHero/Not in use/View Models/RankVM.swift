//
//  RankVM.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/19/22.
//

import Foundation
import Combine

class RankVM {
    @Published var dailyMacro: MacroPlan
    
    init(dailyMacro: MacroPlan) {
        self.dailyMacro = dailyMacro
    }
}

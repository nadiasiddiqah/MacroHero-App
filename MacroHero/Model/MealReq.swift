//
//  MealReq.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/14/22.
//

import Foundation
import UIKit

struct MealReq {
    var type: String?
    var macros: MacroBreakdown?
    var random: Bool = false
    var macroPriority: MacroPriority?
}

struct MacroPriority {
    var macro1: String
    var macro2: String
}

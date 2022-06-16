//
//  MainLabelModel.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/24/22.
//

import Foundation

struct MainLabelModel {
    var title: String
    var type: MainLabelType
    var numberOfLines: Int?
}

enum MainLabelType {
    case onboardingView, tabView
}

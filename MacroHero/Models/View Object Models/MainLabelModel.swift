//
//  MainLabelModel.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/24/22.
//

import Foundation
import UIKit

struct MainLabelModel {
    var title: String
    var type: MainLabelType
    var numberOfLines: Int?
    var textColor: UIColor?
    var font: UIFont?
}

enum MainLabelType {
    case onboardingView, tabView
}

//
//  UserData.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/18/22.
//

import Foundation

struct UserData {
    var age, heightCm, weightKg: String?
    var sex: Sex?
    var activityLevel: Activity?
    var goal: Goal?
}

enum Sex: String {
    case male = "male"
    case female = "female"
}

enum Goal: String {
    case lose = "lose"
    case gain = "gain"
    case maintain = "maintain"
}

enum Activity: String {
    case noExercise = "1"
    case lightExercise = "2"
    case moderateExercise = "3"
    case hardExercise = "4"
}

//
//  MacroData.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/24/22.
//

import Foundation

// MARK: - MacroData
struct MacroData: Codable {
    let statusCode: Int?
    let requestResult: String?
    let data: MacroOptions?
}

// MARK: - DataClass
struct MacroOptions: Codable {
    let calorie: Double?
    let balanced, lowfat, lowcarbs, highprotein: Breakdown?
}

// MARK: - DietType
struct Breakdown: Codable {
    let protein, fat, carbs: Double?
}

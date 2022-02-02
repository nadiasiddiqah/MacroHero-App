//
//  MealData.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/14/22.
//

import Foundation
import UIKit

// MARK: - MealData
struct MealData: Codable {
    let from, to, count: Int?
    let links: MealDataLinks?
    let hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
    let bookmarked, bought: Bool?
    let links: HitLinks?

    enum CodingKeys: String, CodingKey {
        case recipe, bookmarked, bought
        case links
    }
}

// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: Next?

    enum CodingKeys: String, CodingKey {
        case linksSelf
    }
}

// MARK: - Next
struct Next: Codable {
    let href: String?
    let title: Title?
}

enum Title: String, Codable {
    case nextPage = "Next page"
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let images: Images?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels, healthLabels, ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let calories: Double?
    let cuisineType: [String]?
    let mealType: [MealType]?
    let totalNutrients: [String: TotalNutrient]?
}

// MARK: - Images
struct Images: Codable {
    let thumbnail, small, regular, large: ImageInfo?

    enum CodingKeys: String, CodingKey {
        case thumbnail
        case small
        case regular
        case large
    }
}

// MARK: - Large
struct ImageInfo: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
}

enum MealType: String, Codable {
    case breakfast = "breakfast"
}

// MARK: - TotalNutrient
struct TotalNutrient: Codable {
    let label: String?
    let quantity: Double?
    let unit: Unit?
}

enum Unit: String, Codable {
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - MealDataLinks
struct MealDataLinks: Codable {
    let next: Next?
}

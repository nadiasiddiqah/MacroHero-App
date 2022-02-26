//
//  MealData.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/14/22.
//

import Foundation

// MARK: - MealData
struct MealData: Codable {
    let count: Int?
    let hits: [Hit]?
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
    let bookmarked: Bool?
    let links: HitLinks?
}

// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: Next?
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
    let mealType: [MealType]?
    let totalNutrients: [String: TotalNutrient]?
}

// MARK: - Images
struct Images: Codable {
    let thumbnail, small, regular, large: ImageInfo?
    
    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
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
}

enum MealType: String, Codable {
    case breakfast = "breakfast"
    case brunch = "brunch"
    case lunch = "lunch"
    case dinner = "dinner"
    case teatime = "teatime"
    case lunchOrDinner = "lunch/dinner"
    case snack = "snack"
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

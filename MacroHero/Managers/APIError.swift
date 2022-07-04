//
//  APIError.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 7/4/22.
//

import Foundation

enum APIError: String, Error {
    case invalidURL = "Invalid URL"
    case invalidResponseStatus = "Invalid Response Status"
    case dataTaskError = "Error making API Request"
    case corruptData = "API Response Data not available"
    case decodingError = "JSON Data couldn't be decoded to Swift object"
}

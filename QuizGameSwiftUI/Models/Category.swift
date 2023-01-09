//
//  Category.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 04.01.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Struct Category
struct Category: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    
    /// Returns the modified category name.
    var displayName: String {
        return name.replacingOccurrences(of: "Entertainment: ", with: "").replacingOccurrences(of: "Science: ", with: "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

//  MARK: - Struct Categories
struct Categories: Codable {
    let trivia_categories: [Category]
}

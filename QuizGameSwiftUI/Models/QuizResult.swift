//
//  QuizResult.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 09.01.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Struct QuizResult
struct QuizResult: Codable {
    let numberOfQuestions: Int
    let numberOfCorrectAnswers: Int
    let numberOfIncorrectAnswers: Int
    
    /// Returns the success rate as a percentage.
    var successPercentage: Double {
        return Double(numberOfCorrectAnswers) / Double(numberOfQuestions)
    }
    
    // Only for preview.
    static let example = QuizResult(numberOfQuestions: 10, numberOfCorrectAnswers: 5, numberOfIncorrectAnswers: 5)
}

//
//  QuizResult.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 09.01.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Struct QuizResult
struct QuizResult: Codable, Hashable {
    let numberOfQuestions: Int
    let numberOfCorrectAnswers: Int
    let numberOfIncorrectAnswers: Int
    let quizCategory: String
    var creationDate = Date().formatted(date: .abbreviated, time: .omitted)
    
    /// Returns the percentage success rate.
    var percentageSuccessRate: String {
        let percentage = Double(numberOfCorrectAnswers) / Double(numberOfQuestions) * 100.0
        return String(format:"%.2f", percentage)
    }
    
    // Only for preview.
    static let example = QuizResult(numberOfQuestions: 10, numberOfCorrectAnswers: 5, numberOfIncorrectAnswers: 5, quizCategory: "Books")
}

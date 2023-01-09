//
//  Quiz.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 05.01.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Struct Question
struct Question: Codable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    
    /// Returns all answers in one array.
    var allAnswers: [String] {
        var allAnswers = incorrect_answers
        allAnswers.append(correct_answer)
        allAnswers = allAnswers.shuffled()
        return allAnswers
    }
    
    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question, correct_answer, incorrect_answers
    }
    
    // Only for preview.
    static let example = Question(category: "Entertainment: Books", type: "multiple", difficulty: "hard", question: "In the book The Martian how long was Mark Watney trapped on Mars (in Sols)?", correct_answer: "549 Days", incorrect_answers: ["765 Days", "401 Days", "324 Days"])
}


//  MARK: - Struct Quiz
struct Quiz: Codable {
    let response_code: Int
    let results: [Question]
}

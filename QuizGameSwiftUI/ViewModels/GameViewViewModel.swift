//
//  GameViewViewModel.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 05.01.2023.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - Class GameViewViewModel
@MainActor
final class GameViewViewModel: ObservableObject {
    //  MARK: - Constants and variables
    /// Array with downloaded data  of selected quiz.
    private(set) var quiz: [Question]
    
    /// Current question index.
    @Published private(set) var currentQuestion = 0
    
    /// Number of correct answers.
    private(set) var numberOfCorrectAnswers = 0
    
    /// Number of incorrect answers.
    private(set) var numberOfIncorrectAnswers = 0
    
    /// Bool variable to disable the UI.
    @Published private(set) var disabledUI = false
    
    /// EndGameView trigger.
    @Published var showEndGameView = false
    
    /// HapticFeedbackGenerator.
    private let generator = HapticFeedbackGenerator()
    
    /// Quiz history file manager.
    private let quizHistoryFileManager = QuizHistoryFileManager()
    
    //  MARK: - Init
    init(quiz: [Question]) {
        self.quiz = quiz
    }
    
    //  MARK: - Functions
    /// Checks selected answer.
    ///
    /// - Parameters:
    ///     - selectedAnswer: Selected answer.
    func checkAnswer(selectedAnswer: String) {
        disabledUI.toggle()
        
        if selectedAnswer == quiz[currentQuestion].correct_answer.decodeBase64()! {
            numberOfCorrectAnswers += 1
            generator.makeFeedback(type: .correct)
        }
        else {
            numberOfIncorrectAnswers += 1
            generator.makeFeedback(type: .incorrect)
        }
        
        if currentQuestion >= quiz.count - 1{
            quizHistoryFileManager.saveOneObject(object: createQuizResult())
            showEndGameView.toggle()
            return
        }
        else {
            currentQuestion += 1
        }
        
        disabledUI.toggle()
    }
    
    /// Create a QuizResult object.
    func createQuizResult() -> QuizResult {
        return QuizResult(numberOfQuestions: quiz.count, numberOfCorrectAnswers: numberOfCorrectAnswers, numberOfIncorrectAnswers: numberOfIncorrectAnswers, quizCategory: quiz[0].category)
    }
}

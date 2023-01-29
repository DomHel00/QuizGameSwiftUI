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
    @Published private(set) var numberOfCorrectAnswers = 0

    /// Number of incorrect answers.
    @Published private(set) var numberOfIncorrectAnswers = 0
    
    /// Bool variable to disable the UI.
    @Published private(set) var disabledUI = false
    
    /// EndGameView trigger.
    @Published var showEndGameView = false
    
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
        }
        else {
            numberOfIncorrectAnswers += 1
        }
        
        if currentQuestion >= quiz.count - 1{
            disabledUI.toggle()
            showEndGameView.toggle()
        }
        else {
            currentQuestion += 1
        }
        
        disabledUI.toggle()
    }
}

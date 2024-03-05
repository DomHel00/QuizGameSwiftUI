//
//  QuizHistoryViewViewModel.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 12.01.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Class QuizHistoryViewViewModel
final class QuizHistoryViewViewModel: ObservableObject {
    //  MARK: - Constants and variables
    /// Array of quiz results.
    @Published private(set) var quizHistory = [QuizResult]()
    
    /// Manager for saving and loading data from file.
    private let quizHistoryFileManager = QuizHistoryFileManager()
    
    //  MARK: - Init
    init() {
        self.quizHistory = quizHistoryFileManager.loadDataFromFile()
    }
    
    //  MARK: - Functions
    /// Deletes the selected record from the array and file.
    ///
    /// - Parameters:
    ///     - offsets: A collection of unique integer values that represent the indexes of  objects which will be deleted.
    
    func deleteResult(at offsets: IndexSet) {
        quizHistory.remove(atOffsets: offsets)
        quizHistoryFileManager.saveAllDataToFile(data: quizHistory)
    }
}

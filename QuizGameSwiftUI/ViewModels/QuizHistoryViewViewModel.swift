//
//  QuizHistoryViewViewModel.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 12.01.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Class QuizHistoryViewViewModel
@MainActor
final class QuizHistoryViewViewModel: ObservableObject {
    //  MARK: - Constants and variables
    /// Array of quiz results.
    @Published private(set) var quizHistory = [QuizResult]()
    
    //  MARK: - Init
    /// When initializing, the results from the file are load into the array, if there are any.
    init() {
        do {
            let data = try Data(contentsOf: Constants.savedQuizHistoryURL)
            let decodedData = try JSONDecoder().decode([QuizResult].self, from: data)
            self.quizHistory = decodedData
        }
        catch {
            self.quizHistory = []
            print(error)
        }
    }
    
    //  MARK: - Functions
    /// Adds a new record to the array.
    func addNewResult(quizResult: QuizResult) {
        quizHistory.append(quizResult)
        saveData()
    }
    
    /// Deletes the selected record from the array.
    func deleteResult(at offsets: IndexSet) {
        quizHistory.remove(atOffsets: offsets)
        saveData()
    }
    
    /// Saves data to file.
    private func saveData() {
        do {
            let encodedData = try JSONEncoder().encode(quizHistory)
            try encodedData.write(to: Constants.savedQuizHistoryURL, options: [.atomic])
        }
        catch {
            print(error)
        }
    }
}

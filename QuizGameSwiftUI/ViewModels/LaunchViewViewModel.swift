//
//  LaunchViewViewModel.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 04.01.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Class LaunchViewViewModel
@MainActor
final class LaunchViewViewModel: ObservableObject {
    //  MARK: - Constants and variables
    /// Array with downloaded data  of categories.
    @Published private(set) var categories = [Category]()
    
    /// Array with downloaded data  of selected quiz.
    private(set) var quiz = [Question]()

    /// Alerts trigger.
    @Published var showAlert = false
    
    /// Internet connection alerts trigger.
    @Published var showInternetConnectionAlert = false
    
    /// Alert message.
    private(set) var message = ""
    
    /// Bool variable to disable the UI.
    @Published private(set) var disabledUI = false
    
    /// Variable to determine if the quiz data has already been downloaded.
    @Published var isQuizLoaded = false
    
    /// Loading state enum.
    enum LoadingState {
        case loading, loaded, failed
    }
    
    /// Fetch function type enum.
    enum fetchFunctionType {
        case categories, quiz
    }
    
    /// Holds current lloading state.
    private(set) var state: LoadingState = .loading
    
    /// Holds current fetch function type.
    private(set) var fetchType: fetchFunctionType = .categories
    
    /// ID of the selected quiz category.
    var selectedCategoryID: Int?
    
    /// SettingsView trigger.
    @Published var showSettingsView = false
    
    /// QuizHistoryView trigger.
    @Published var showQuizHistoryView = false
    
    //  MARK: - Functions
    /// Fetchs all categories.
    func fetchCategories() async {
        disabledUI.toggle()
        fetchType = .categories
        
        if InternetConnectionMonitor.shared.isConnected {
            do {
                let categories: Categories = try await APICaller.shared.fetchData(urlString: "https://opentdb.com/api_category.php")
                self.categories = categories.trivia_categories
                self.categories.remove(at: 16)
                self.categories.remove(at: 20)

                self.state = .loaded
                self.disabledUI.toggle()
            }
            catch {
                self.state = .failed
                self.showAlert = true
                self.message = error.localizedDescription
                self.disabledUI.toggle()
            }
        }
        else {
            self.showInternetConnectionAlert = true
            self.message = "No internet connection"
            self.disabledUI.toggle()
        }
    }
    
    /// Fetchs data for selected quiz category.
    func fetchQuiz() async {
        fetchType = .quiz
        disabledUI.toggle()
        state = .loading
        
        let numberOfQuestions = UserDefaults.standard.integer(forKey: "numberOfQuestions")
        
        if InternetConnectionMonitor.shared.isConnected {
            do {
                let quiz: Quiz = try await APICaller.shared.fetchData(urlString: "https://opentdb.com/api.php?amount=\(numberOfQuestions)&category=\(selectedCategoryID!)&encode=base64")
                self.quiz = quiz.results
                self.state = .loaded
                disabledUI.toggle()
                isQuizLoaded = true
            }
            catch {
                self.state = .failed
                self.showAlert = true
                self.message = error.localizedDescription
                self.disabledUI.toggle()
            }
        }
        else {
            self.showInternetConnectionAlert = true
            self.message = "No internet connection"
            disabledUI.toggle()
        }
    }
}

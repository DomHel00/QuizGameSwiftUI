//
//  LaunchView.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 04.01.2023.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - Struct LaunchView
struct LaunchView: View {
    //  MARK: - Constants and variables
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @StateObject private var viewModel = LaunchViewViewModel()

    //  MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                /// NavigationLink for GameView.
                NavigationLink(isActive: $viewModel.isQuizLoaded) {
                    GameView(viewModel: GameViewViewModel(quiz: viewModel.quiz))
                } label: {
                    EmptyView()
                }
                
                /// NavigationLink for SettingsView.
                NavigationLink(isActive: $viewModel.showSettingsView) {
                    SettingsView()
                } label: {
                    EmptyView()
                }
                
                /// NavigationLink for QuizHistoryView.
                NavigationLink(isActive: $viewModel.showQuizHistoryView) {
                    QuizHistoryView()
                } label: {
                    EmptyView()
                }
                
                /// List of categories.
                List {
                    ForEach(viewModel.filteredcategories) { category in
                        HStack {
                            Button("\(category.displayName)") {
                                // We need to hide the keyboard before displaying GameView.
                                UIApplication.shared.endEditing()
                                viewModel.selectedCategoryID = category.id
                                Task {
                                    await viewModel.fetchQuiz()
                                }
                            }
                            .foregroundColor(.init(uiColor: .label))

                            Spacer()
                            
                            Image(systemName: "arrow.right")
                        }
                        .blur(radius: viewModel.state == .loading ? CGFloat(5) : CGFloat(0))
                        .accessibilityElement()
                        .accessibilityLabel("Category:")
                        .accessibilityValue(category.displayName)
                        .accessibilityHint("Double tap to start the quiz.")
                    }
                }
                .listStyle(.grouped)
                
                /// Shows LoadingView by loading state.
                if viewModel.state == .loading && viewModel.showInternetConnectionAlert == false {
                    LoadingView()
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.showQuizHistoryView.toggle()
                    } label: {
                        Label("History", systemImage: "doc.text")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showSettingsView.toggle()
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.xLarge)
        .searchable(text: $viewModel.searchText, placement: .toolbar, prompt: "Search a category...")
        .autocorrectionDisabled()
        .disabled(viewModel.disabledUI)
        .task {
            await viewModel.fetchCategories()
        }
        .alert("No internet connection", isPresented: $viewModel.showInternetConnectionAlert) {
            Button {
                Task {
                    switch viewModel.fetchType {
                    case .categories:
                        await viewModel.fetchCategories()

                    case .quiz:
                        await viewModel.fetchQuiz()
                    }
                }
            } label: {
                Text("Try again")
            }
        } message: {
            Text(viewModel.message)
        }
        .alert("Fatal error", isPresented: $viewModel.showAlert) {
            Button {}
        label: {
            Text("Ok")
        }
        } message: {
            Text(viewModel.message)
        }
    }
}

//  MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

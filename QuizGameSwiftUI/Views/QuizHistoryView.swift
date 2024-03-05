//
//  QuizHistoryView.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 07.01.2023.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - Struct QuizHistoryView
struct QuizHistoryView: View {
    //  MARK: - Constants and variables
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @StateObject private var viewModel = QuizHistoryViewViewModel()
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.quizHistory, id: \.self) { quiz in
                    NavigationLink {
                        EndGameView(quizResult: quiz)
                    } label: {
                        QuizHistoryListCell(quiz: quiz)
                    }
                }
                .onDelete(perform: viewModel.deleteResult(at:))
            }
            .listStyle(.plain)
            
            if viewModel.quizHistory.isEmpty {
                Text("No quiz history yet!")
                    .font(.title)
                    .bold()
            }
        }
        .toolbar {
            ToolbarItem {
                EditButton()
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.xLarge)
        .navigationTitle("Quiz history")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//  MARK: - Preview
struct QuizHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        QuizHistoryView()
    }
}

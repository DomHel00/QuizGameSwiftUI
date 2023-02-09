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
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Quiz: \(quiz.quizCategory.decodeBase64()!.replacingOccurrences(of: "Entertainment: ", with: "").replacingOccurrences(of: "Science: ", with: ""))")
                                    .font(.headline)
                                    .bold()
                                
                                Text("\(quiz.creationDate)")
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            Text("\(quiz.percentageSuccessRate)%")
                                .font(.headline)
                                .bold()
                        }
                        .accessibilityElement()
                        .accessibilityLabel("Quiz: \(quiz.quizCategory.decodeBase64()!.replacingOccurrences(of: "Entertainment: ", with: "").replacingOccurrences(of: "Science: ", with: "")) completed on \(quiz.creationDate) with \(quiz.percentageSuccessRate)% success rate.")
                        .accessibilityHint("Double tap to view details.")
                    }
                }
                .onDelete(perform: viewModel.deleteResult(at:))
            }
            .listStyle(.grouped)
            
            if viewModel.quizHistory.isEmpty {
                Text("No quiz history")
                    .font(.headline)
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

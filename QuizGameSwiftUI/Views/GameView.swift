//
//  GameView.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 05.01.2023.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - Struct GameView
struct GameView: View {
    //  MARK: - Constants and variables
    @Environment(\.dismiss) var dismiss
    @Environment(\.dismissSearch) var dismissSearch
    @StateObject private var viewModel: GameViewViewModel
    
    //  MARK: - Init
    init(viewModel: GameViewViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            /// Logo.
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: Constants.width, height: Constants.width)
                    .scaledToFit()
                    .opacity(0.2)
            }
            .accessibilityElement()
            .accessibilityHidden(true)
            
            /// Number of correct answers, current question, number of incorrect answers.
            VStack {
                HStack {
                    VStack {
                        Text("\(viewModel.numberOfCorrectAnswers)")
                            .font(.title)
                            .bold()
                        
                        Text("Correct")
                            .font(.callout)
                            .bold()
                    }
                    .foregroundColor(.green)
                    .padding(.horizontal)
                    .accessibilityElement()
                    .accessibilityLabel("Number of correct answers is")
                    .accessibilityValue("\(viewModel.numberOfCorrectAnswers)")
                    
                    Spacer()
                    
                    Text("\(viewModel.currentQuestion + 1)/\(viewModel.quiz.count)")
                        .font(.title)
                        .bold()
                        .accessibilityElement()
                        .accessibilityLabel("Question \(viewModel.currentQuestion + 1) of \(viewModel.quiz.count)")
                    
                    Spacer()
                    
                    VStack {
                        Text("\(viewModel.numberOfIncorrectAnswers)")
                            .font(.title)
                            .bold()
                        
                        Text("Incorrect")
                            .font(.callout)
                            .bold()
                    }
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    .accessibilityElement()
                    .accessibilityLabel("Number of incorrect answers is")
                    .accessibilityValue("\(viewModel.numberOfIncorrectAnswers)")
                }
                
                Spacer()
                
                /// Current question.
                Text(viewModel.quiz[viewModel.currentQuestion].question.decodeBase64() ?? "No")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(8)
                
                Spacer()
                
                /// Answer buttons.
                ForEach(viewModel.quiz[viewModel.currentQuestion].allAnswers, id: \.self) { answer in
                    Button {
                        let selectedAnswer = answer.decodeBase64()!
                        viewModel.checkAnswer(selectedAnswer: selectedAnswer)
                    } label: {
                        Text(answer.decodeBase64()!)
                            .frame(width: Constants.width - 16, height: 55)
                            .padding(8)
                            .foregroundColor(.primary)
                            .border(Color.primary)
                            .multilineTextAlignment(.center)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.primary, lineWidth: 2)
                            )
                            .disabled(viewModel.disabledUI)
                    }
                    .accessibilityElement()
                    .accessibilityLabel("Answer:")
                    .accessibilityValue("\(answer.decodeBase64()!)")
                    .accessibilityHint("Double tap to confirm the selected answer.")
                }
                .navigationTitle("Quiz")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        /// Result sheet.
        .sheet(isPresented: $viewModel.showEndGameView) {
            let quizResult = QuizResult(numberOfQuestions: viewModel.quiz.count, numberOfCorrectAnswers: viewModel.numberOfCorrectAnswers, numberOfIncorrectAnswers: viewModel.numberOfIncorrectAnswers, quizCategory: viewModel.quiz[0].category)
            // Save to quiz history.
            QuizHistoryViewViewModel().addNew(quizResult: quizResult)
            dismiss()
        } content: {
            let quizResult = QuizResult(numberOfQuestions: viewModel.quiz.count, numberOfCorrectAnswers: viewModel.numberOfCorrectAnswers, numberOfIncorrectAnswers: viewModel.numberOfIncorrectAnswers, quizCategory: viewModel.quiz[0].category)
            NavigationView {
                EndGameView(quizResult: quizResult)
            }
        }
        /// Closes the "searchBar" in LaunchView.
        .onDisappear {
            withAnimation {
                dismissSearch()
            }
        }
    }
}

//  MARK: - Preview
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewViewModel(quiz: []))
    }
}

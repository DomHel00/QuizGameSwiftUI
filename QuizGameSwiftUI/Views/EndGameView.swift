//
//  EndGameView.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 07.01.2023.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - Struct EndGameView
struct EndGameView: View {
    //  MARK: - Constants and variables
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    private let quizResult: QuizResult
    
    //  MARK: - Init
    init(quizResult: QuizResult) {
        self.quizResult = quizResult
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
            
            /// Number of correct and incorrect answers, success percentage.
            VStack {
                Text("Number of questions:\n\(quizResult.numberOfQuestions)")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                    
                HStack {
                    VStack {
                        Text("\(quizResult.numberOfCorrectAnswers)")
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
                    .accessibilityValue("\(quizResult.numberOfCorrectAnswers)")
                    
                    Spacer()
                    
                    VStack {
                        Text("\(quizResult.numberOfIncorrectAnswers)")
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
                    .accessibilityValue("\(quizResult.numberOfIncorrectAnswers)")

                }
                
                Text("Your success percentage:\n\(quizResult.percentageSuccessRate)%")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Your results")
            .navigationBarTitleDisplayMode(.inline)
        }
        .dynamicTypeSize(...DynamicTypeSize.xLarge)
    }
}

//  MARK: - Preview
struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView(quizResult: QuizResult.example)
    }
}

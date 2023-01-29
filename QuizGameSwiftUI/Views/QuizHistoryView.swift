//
//  QuizHistoryView.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 07.01.2023.
//

import SwiftUI
import Photos

struct QuizHistoryView: View {
    @StateObject private var viewModel = QuizHistoryViewViewModel()
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: Constants.width * 0.35, height: Constants.width * 0.35, alignment: .center)
                        .scaledToFit()
                    
                    Spacer()
                }
            }
            
            Section("History") {
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
                        .edgesIgnoringSafeArea([.leading, .trailing])
                        .frame(maxWidth: .infinity)

                    }
                }
            }
        }
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

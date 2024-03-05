//
//  QuizHistoryListCell.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 05.03.2024.
//

import SwiftUI

struct QuizHistoryListCell: View {
    let quiz: QuizResult
    
    var body: some View {
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
        .accessibilityHint("Double tap to view details.")    }
}

#Preview {
    QuizHistoryListCell(quiz: QuizResult(numberOfQuestions: 10, numberOfCorrectAnswers: 5, numberOfIncorrectAnswers: 5, quizCategory: "Books", creationDate: ""))
}

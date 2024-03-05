//
//  QuizHistoryListCell.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 05.03.2024.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - QuizHistoryListCell
struct QuizHistoryListCell: View {
    //  MARK: - Constants and variables
    let quiz: QuizResult
    
    //  MARK: - Body
    var body: some View {
        /// QuizHistory list cell.
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

//  MARK: - Preview
#Preview {
    QuizHistoryListCell(quiz: QuizResult.example)
}

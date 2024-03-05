//
//  CategoriesListCell.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 05.03.2024.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - Struct CategoriesListCell
struct CategoriesListCell: View {
    //  MARK: - Constants and variables
    let category: Category
    let action: () -> Void
    
    //  MARK: - Body
    var body: some View {
        /// Categories list cell.
        HStack {
            Button("\(category.displayName)") {
                action()
            }
            .foregroundColor(.init(uiColor: .label))
            
            Spacer()
            
            Image(systemName: "arrow.right")
        }
    }
}

//  MARK: - Preview
#Preview {
    CategoriesListCell(category: Category(id: 1, name: "Books")) { }
}

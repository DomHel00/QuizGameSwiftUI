//
//  CategoriesListCell.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 05.03.2024.
//

import SwiftUI

struct CategoriesListCell: View {
    let category: Category
    let action: () -> Void
    
    var body: some View {
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

#Preview {
    CategoriesListCell(category: Category(id: 1, name: "Books")) {
        
    }
}

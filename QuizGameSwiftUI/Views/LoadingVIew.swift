//
//  LoadingView.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 04.01.2023.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - Struct LoadingView
struct LoadingView: View {
    //  MARK: - Constants and variables
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    //  MARK: - Body
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(x: 2, y: 2, anchor: .center)
                .padding()
                .tint(.init(uiColor: .label))
            
            Text("Downloading data...")
                .multilineTextAlignment(.center)
                .padding()
        }
        .dynamicTypeSize(...DynamicTypeSize.xxLarge)
        .frame(width: Constants.width * 0.4, height: Constants.width * 0.4)
        .border(Color.primary)
        .background(Color(.quaternaryLabel))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.secondary, lineWidth: 2)
        )
        .accessibilityElement()
        .accessibilityLabel("Downloading data.")
    }
}

//  MARK: - Preview
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

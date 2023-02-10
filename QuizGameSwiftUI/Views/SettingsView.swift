//
//  SettingsView.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 06.01.2023.
//

//  MARK: - Imports
import SwiftUI

//  MARK: - Struct SettingsView
struct SettingsView: View {
    //  MARK: - Constants and variables
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @AppStorage("numberOfQuestions") var numberOfQuestions = 10
    @AppStorage("hapticFeedback") var hapticFeedback = false
    private let choices = [5, 10, 15, 20, 25, 30]
    
    //  MARK: - Body
    var body: some View {
        /// Form containing settings.
        Form {
            Section("Number of questions") {
                VStack {
                    Text("Choose how many questions the quiz will contain")
                        .multilineTextAlignment(.center)
                    Picker("Choose how many questions the quiz will contain.", selection: $numberOfQuestions) {
                        ForEach(choices, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()
                
                Spacer()
            }
            
            Section("Haptic feedback") {
                Toggle(isOn: $hapticFeedback) {
                    Text("Use haptic feedback")
                }
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.xLarge)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//  MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

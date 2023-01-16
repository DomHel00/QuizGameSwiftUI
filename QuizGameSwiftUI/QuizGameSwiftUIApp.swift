//
//  QuizGameSwiftUIApp.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 04.01.2023.
//

import SwiftUI

@main
struct QuizGameSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .onAppear {
                    InternetConnectionMonitor.shared.startMonitoring()
                    
                    // Setting the default value when the application is first started.
                    if UserDefaults.standard.integer(forKey: "numberOfQuestions") == 0 {
                        UserDefaults.standard.set(10, forKey: "numberOfQuestions")
                    }
                }
        }
    }
}

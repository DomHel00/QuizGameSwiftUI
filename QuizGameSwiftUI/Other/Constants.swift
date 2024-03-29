//
//  Constants.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 08.01.2023.
//

//  MARK: - Imports
import SwiftUI

/// Just some constants.
enum Constants {
    public static let width = UIScreen.main.bounds.width
    public static let savedQuizHistoryURL = FileManager.documentsDirectory.appendingPathComponent("savedQuizHistory")
}

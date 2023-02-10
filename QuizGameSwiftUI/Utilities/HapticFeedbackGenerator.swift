//
//  HapticFeedbackGenerator.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 09.02.2023.
//

//  MARK: - Imports
import UIKit

//  MARK: - Class HapticFeedbackGenerator
final class HapticFeedbackGenerator {
    //  MARK: - Constants and variables
    /// Feedback generator.
    private let generator: UINotificationFeedbackGenerator
    
    /// Haptic feedback type.
    enum HapticFeedbackType {
        case correct, incorrect
    }
    
    //  MARK: - Init
    init() {
        self.generator = UINotificationFeedbackGenerator()
    }
    
    //  MARK: - Functions
    /// Makes haptic feedback according to the "type" parameter.
    func makeFeedback(type: HapticFeedbackType) {
        if UserDefaults.standard.bool(forKey: "hapticFeedback") {
            switch type {
            case .correct:
                generator.notificationOccurred(.success)
            case .incorrect:
                generator.notificationOccurred(.error)
            }
        }
    }
}

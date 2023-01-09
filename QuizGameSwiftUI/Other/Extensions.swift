//
//  Extensions.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 09.01.2023.
//

import Foundation

/// Extension of the String structure by a function for decoding.
extension String {
    func decodeBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

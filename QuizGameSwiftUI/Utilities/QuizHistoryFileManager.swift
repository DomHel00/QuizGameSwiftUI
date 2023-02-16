//
//  QuizHistoryFileManager.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 15.02.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Class QuizHistoryFileManager
final class QuizHistoryFileManager {
    //  MARK: - Functions
    /// Returns all data from file.
    func loadDataFromFile() -> [QuizResult] {
        if FileManager.default.fileExists(atPath: Constants.savedQuizHistoryURL.path) {
            do {
                let data = try Data(contentsOf: Constants.savedQuizHistoryURL)
                
                if data.isEmpty {
                    return []
                }
                
                let decodedData = try JSONDecoder().decode([QuizResult].self, from: data)
                return decodedData.reversed()
            }
            catch {
                print(error.localizedDescription)
                return []
            }
        }
        else {
            return []
        }
    }
    
    /// Saves given data to file.
    ///
    /// - Parameters:
    ///     - data: The data which will be saved.
    func saveAllDataToFile(data: [QuizResult]) {
        if !FileManager.default.fileExists(atPath: Constants.savedQuizHistoryURL.path) {
            FileManager.default.createFile(atPath: Constants.savedQuizHistoryURL.path, contents: nil)
        }
        
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: Constants.savedQuizHistoryURL, options: [.atomic])
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    /// Adding one object to file.
    ///
    /// - Parameters:
    ///     - object: The object which will be adding to the file.
    func saveOneObject(object: QuizResult) {
        if !FileManager.default.fileExists(atPath: Constants.savedQuizHistoryURL.path) {
            FileManager.default.createFile(atPath: Constants.savedQuizHistoryURL.path, contents: nil)
        }
        
        var allDataFromFile = loadDataFromFile()
        allDataFromFile.append(object)
        
        saveAllDataToFile(data: allDataFromFile)
    }
}

//
//  APICaller.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 04.01.2023.
//

//  MARK: - Imports
import Foundation

//  MARK: - Class APICaller
final class APICaller {
    //  MARK: - Constants and variables
    /// Shared property.
    static let shared = APICaller()
    
    //  MARK: - Inits
    private init() {}
    
    //  MARK: - Enums
    enum APICallerError: String, Error {
        case invalidURL = "Invalid URL! Please contact us."
        case dataTaskError = "Fatal eror during task! Please contact us"
        case decodingError = "Fatal eror during decoding! Please contact us"
    }
    
    //  MARK: - Functions
    /// Generic function for fetching data.
    public func fetchData<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APICallerError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dataDecodingStrategy = .base64
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            }
            catch {
                print(error.localizedDescription)
                throw APICallerError.decodingError
            }
        }
        catch {
            throw APICallerError.dataTaskError
        }
    }
}

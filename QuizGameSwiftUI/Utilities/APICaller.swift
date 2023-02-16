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
    /// Custom errors.
    enum APICallerError: Error, LocalizedError {
        case invalidURL
        case dataTaskError
        case decodingError
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return NSLocalizedString("The endpoint URL is invalid.", comment: "")
            case .dataTaskError:
                return NSLocalizedString("Fatal eror during task.", comment: "")
            case .decodingError:
                return NSLocalizedString("Fatal eror during decoding.", comment: "")
            }
        }
    }
    
    //  MARK: - Functions
    /// Generic function for fetching data.
    ///
    /// - Parameters:
    ///     - urlString: URL address from which the data will be fetch.
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

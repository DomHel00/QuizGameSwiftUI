//
//  InternetConnectionMonitor.swift
//  QuizGameSwiftUI
//
//  Created by Dominik Hel on 04.01.2023.
//

//  MARK: - Imports
import SwiftUI
import Network

//  MARK: - Class InternetConnectionMonitor
final class InternetConnectionMonitor {
    //  MARK: - Constants and variables
    /// Shared property.
    public static let shared = InternetConnectionMonitor()
    
    /// Monitor.
    private let monitor = NWPathMonitor()
    
    /// Variable for storing the connection state.
    private(set) var isConnected = false
    
    //  MARK: - Init
    private init() {}
    
    //  MARK: - Functions
    /// Starts monitoring internet connection.
    public func startMonitoring() {
        monitor.start(queue: DispatchQueue.global())
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
    }
    
    /// Stops monitoring internet connection.
    public func stopMonitoring() {
        monitor.cancel()
    }
}

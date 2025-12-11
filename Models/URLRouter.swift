import Foundation
import SwiftUI

/// URLRouter handles custom URL schemes for the Word Guess app
class URLRouter: ObservableObject {
    @Published var activeRoute: AppRoute? = nil
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    /// Available routes in the app
    enum AppRoute: Equatable {
        case game
        case leaderboard
        case newGame
        case gameWithWord(String)
        case unknown(String)
    }
    
    /// Handle incoming URLs and route to appropriate screens
    func handle(_ url: URL) -> Bool {
        print("🔗 URLRouter handling URL: \(url)")
        
        guard url.scheme == "wordguess" else {
            print("⚠️ Unknown URL scheme: \(url.scheme ?? "nil")")
            return false
        }
        
        let host = url.host ?? ""
        let path = url.path
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems
        
        print("🔗 URL Details:")
        print("   Host: \(host)")
        print("   Path: \(path)")
        print("   Query Items: \(queryItems?.description ?? "none")")
        
        // Route based on host and path
        switch host {
        case "game":
            if path == "/new" {
                activeRoute = .newGame
                print("✅ Routing to: New Game")
                return true
            } else if let wordParam = queryItems?.first(where: { $0.name == "word" })?.value {
                activeRoute = .gameWithWord(wordParam)
                print("✅ Routing to: Game with word '\(wordParam)'")
                return true
            } else {
                activeRoute = .game
                print("✅ Routing to: Game Screen")
                return true
            }
            
        case "leaderboard":
            activeRoute = .leaderboard
            print("✅ Routing to: Leaderboard")
            return true
            
        default:
            activeRoute = .unknown(url.absoluteString)
            alertMessage = "Unknown URL: \(url.absoluteString)"
            showAlert = true
            print("❌ Unknown route: \(host)")
            return false
        }
    }
    
    /// Clear the current route
    func clearRoute() {
        activeRoute = nil
        print("🔗 Route cleared")
    }
    
    /// Generate example URLs for testing
    static let exampleURLs: [String: String] = [
        "Open Game": "wordguess://game",
        "New Game": "wordguess://game/new", 
        "Game with Word": "wordguess://game?word=SWIFT",
        "Leaderboard": "wordguess://leaderboard"
    ]
}

/// Extension to provide URL examples for testing
extension URLRouter {
    /// Print testing instructions to console
    static func printTestingInstructions() {
        print("🔗 === URL SCHEME TESTING INSTRUCTIONS ===")
        print("📱 Test these URLs in Safari or Notes app:")
        
        for (description, url) in exampleURLs {
            print("   \(description): \(url)")
        }
        
        print("")
        print("💡 How to test:")
        print("   1. Open Safari on your device/simulator")
        print("   2. Type one of the URLs above in the address bar")
        print("   3. Tap 'Go' - iOS will prompt to open your app")
        print("   4. Check console for routing messages")
        print("")
        print("📋 Or copy URLs to Notes and tap them")
        print("🔗 =====================================")
    }
}


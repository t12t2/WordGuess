import SwiftUI

struct ContentView: View {
    @EnvironmentObject var urlRouter: URLRouter
    @EnvironmentObject var analytics: AnalyticsManager
    
    var body: some View {
        GameView()
            .onChange(of: urlRouter.activeRoute) { route in
                handleURLRoute(route)
            }
    }
    
    /// Handle URL routing changes
    private func handleURLRoute(_ route: URLRouter.AppRoute?) {
        guard let route = route else { return }
        
        print("🔗 ContentView handling route: \(route)")
        
        switch route {
        case .game:
            // Navigate to game screen (already default)
            print("✅ Navigating to game screen")
            
        case .newGame:
            // Trigger a new game
            print("✅ Starting new game via URL")
            NotificationCenter.default.post(name: .startNewGameFromURL, object: nil)
            
        case .gameWithWord(let word):
            // Start game with specific word (for testing purposes)
            print("✅ Starting game with word: \(word)")
            NotificationCenter.default.post(name: .startGameWithWord, object: word)
            
        case .leaderboard:
            // Navigate to leaderboard
            print("✅ Navigating to leaderboard")
            NotificationCenter.default.post(name: .showLeaderboardFromURL, object: nil)
            
        case .unknown(let url):
            print("❌ Unknown URL route: \(url)")
        }
        
        // Clear route after handling
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            urlRouter.clearRoute()
        }
    }
}

// MARK: - Notification Names for URL Routing
extension Notification.Name {
    static let startNewGameFromURL = Notification.Name("startNewGameFromURL")
    static let startGameWithWord = Notification.Name("startGameWithWord") 
    static let showLeaderboardFromURL = Notification.Name("showLeaderboardFromURL")
}

#Preview {
    ContentView()
}


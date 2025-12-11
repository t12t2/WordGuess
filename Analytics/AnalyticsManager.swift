import Foundation
import AmplitudeSwift
import AmplitudeSwiftSessionReplayPlugin
import AmplitudeEngagementSwift

class AnalyticsManager: ObservableObject {
    private let amplitude: Amplitude
    private let sessionReplayPlugin: AmplitudeSwiftSessionReplayPlugin
    private let amplitudeEngagement: AmplitudeEngagement
    @Published var totalGuesses: Int = 0
    
    init() {
        // Amplitude API key - Replace with your own Amplitude API key
        let apiKey = "API_Key"
        
        let configuration = Configuration(
            apiKey: apiKey,
            autocapture: .all
        )
        
        self.amplitude = Amplitude(configuration: configuration)
        
        // Initialize Session Replay Plugin with 100% sampling rate
        self.sessionReplayPlugin = AmplitudeSwiftSessionReplayPlugin(sampleRate: 1.0)
        
        // Add Session Replay plugin to Amplitude
        self.amplitude.add(plugin: sessionReplayPlugin)
        
        // Initialize Guides and Surveys SDK
        self.amplitudeEngagement = AmplitudeEngagement(apiKey)
        
        // Add Guides & Surveys plugin to Amplitude
        self.amplitude.add(plugin: amplitudeEngagement.getPlugin())
        
        // Configure Guides and Surveys theme mode (auto-detect light/dark mode)
        self.amplitudeEngagement.setThemeMode(themeMode: .auto)
        
        // Boot the SDK immediately with a device ID so it can handle preview URLs
        let deviceId = UUID().uuidString
        let bootOptions = AmplitudeBootOptions(
            user_id: nil,
            device_id: deviceId,
            user_properties: [:]
        )
        self.amplitudeEngagement.boot(options: bootOptions)
        
        print("✅ Guides and Surveys SDK initialized and booted")
        print("✅ Session Replay enabled with 100% sampling rate")
        print("✅ Amplitude SDK with Guides & Surveys ready for preview URLs")
        print("📱 Device ID: \(deviceId)")
    }
    
    // MARK: - Session Replay Controls
    
    /// Disable session replay (useful for sensitive screens)
    func disableSessionReplay() {
        amplitude.remove(plugin: sessionReplayPlugin)
        print("Session Replay disabled")
    }
    
    /// Re-enable session replay after disabling
    func enableSessionReplay() {
        amplitude.add(plugin: sessionReplayPlugin)
        print("Session Replay re-enabled")
    }
    
    // MARK: - Guides and Surveys Controls
    
    /// Boot the Guides and Surveys SDK with user ID
    func bootGuidesAndSurveys(userId: String?, deviceId: String? = nil) {
        if let userId = userId {
            // Boot with user ID and optional device ID
            let bootOptions = AmplitudeBootOptions(
                user_id: userId,
                device_id: deviceId,
                user_properties: [:]
            )
            amplitudeEngagement.boot(options: bootOptions)
        } else {
            // Boot with device ID only
            let bootOptions = AmplitudeBootOptions(
                user_id: nil,
                device_id: deviceId ?? UUID().uuidString,
                user_properties: [:]
            )
            amplitudeEngagement.boot(options: bootOptions)
        }
        print("Guides and Surveys SDK booted")
    }
    
    /// Track screen views for guide targeting
    func trackScreen(_ screenName: String) {
        amplitudeEngagement.screen(screenName)
        print("Screen tracked: \(screenName)")
    }
    
    /// Show a specific guide or survey by key
    func showGuide(key: String) {
        amplitudeEngagement.show(key: key)
        print("Showing guide: \(key)")
    }
    
    /// Close all active guides and surveys
    func closeAllGuides() {
        amplitudeEngagement.closeAll()
        print("All guides closed")
    }
    
    /// Reset a guide to a specific step
    func resetGuide(key: String, stepIndex: Int = 0) {
        amplitudeEngagement.reset(key: key, stepIndex: stepIndex)
        print("Guide reset: \(key) to step \(stepIndex)")
    }
    
    /// Get list of all live guides and surveys
    func getGuidesAndSurveys() -> [Any] {
        let list = amplitudeEngagement.list()
        print("Retrieved guides and surveys list")
        return list
    }
    
    /// Handle URL for preview mode (for testing guides)
    func handlePreviewURL(_ url: URL) -> Bool {
        print("🔍 Attempting to handle Amplitude preview URL: \(url)")
        print("   📋 Full URL: \(url.absoluteString)")
        print("   🌐 Scheme: \(url.scheme ?? "none")")
        print("   🏠 Host: \(url.host ?? "none")")
        
        let handled = amplitudeEngagement.handleUrl(url)
        
        if handled {
            print("✅ Preview URL handled successfully by Amplitude Engagement!")
        } else {
            print("❌ Preview URL NOT handled by Amplitude Engagement")
            print("   ⚠️  Make sure:")
            print("      1. The URL matches your Amplitude URL scheme")
            print("      2. You're using a preview link from Amplitude dashboard")
            print("      3. The SDK has been booted with boot()")
        }
        
        return handled
    }
    
    // MARK: - User Properties
    
    func setUserId(_ userId: String?) {
        amplitude.setUserId(userId: userId)
        bootGuidesAndSurveys(userId: userId)
    }
    
    func resetDeviceId() {
        let newDeviceId = UUID().uuidString
        amplitude.setDeviceId(deviceId: newDeviceId)
    }
    
    func incrementTotalGuesses() {
        totalGuesses += 1
        
        let identify = Identify()
        identify.set(property: "total guesses", value: totalGuesses)
        amplitude.identify(identify: identify)
    }
    
    func resetTotalGuesses() {
        totalGuesses = 0
        
        let identify = Identify()
        identify.unset(property: "total guesses")
        amplitude.identify(identify: identify)
    }
    
    // MARK: - Event Tracking
    
    func trackGameStarted() {
        resetDeviceId() // Reset device ID each time user starts a game
        resetTotalGuesses() // Reset total guesses at start of new game
        
        bootGuidesAndSurveys(userId: nil)
        trackScreen("GameScreen")
        
        amplitude.track(eventType: "game started")
    }
    
    func trackWordGuessed(word: String, lettersInSecretWordCount: Int, correctPositionLettersCount: Int, incorrectPositionLettersCount: Int) {
        incrementTotalGuesses() // Increment before tracking the event
        
        amplitude.track(
            eventType: "word guessed",
            eventProperties: [
                "word": word,
                "letters in secret word count": lettersInSecretWordCount,
                "correct position letters count": correctPositionLettersCount,
                "incorrect position letters count": incorrectPositionLettersCount
            ]
        )
    }
    
    func trackGameRestarted() {
        resetTotalGuesses() // Reset total guesses on restart
        
        amplitude.track(eventType: "game restarted")
    }
    
    func trackGameEnded(didWin: Bool, didGameComplete: Bool) {
        amplitude.track(
            eventType: "game ended",
            eventProperties: [
                "win game": didWin,
                "game complete": didGameComplete
            ]
        )
        
        trackScreen("LeaderboardScreen")
        
        resetTotalGuesses() // Reset total guesses after game ends
    }
    
    func trackHintRequested(hintCount: Int, pointPenalty: Int) {
        amplitude.track(
            eventType: "hint requested",
            eventProperties: [
                "hint count": hintCount,
                "point penalty": pointPenalty
            ]
        )
    }
    
    func trackErrorEncountered(invalidWord: String, errorMessage: String) {
        amplitude.track(
            eventType: "error encountered",
            eventProperties: [
                "invalid word": invalidWord,
                "error message": errorMessage
            ]
        )
    }
    
}

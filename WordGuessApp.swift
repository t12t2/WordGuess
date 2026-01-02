import SwiftUI

@main
struct WordGuessApp: App {
    @StateObject private var analytics = AnalyticsManager()
    @StateObject private var urlRouter = URLRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(analytics)
                .environmentObject(urlRouter)
                .onOpenURL { url in
                    print("📱 App received URL: \(url)")
                    
                    // Check if this is an Amplitude preview URL first (high priority)
                    let urlString = url.absoluteString.lowercased()
                    let urlScheme = url.scheme?.lowercased() ?? ""
                    
                    if urlString.contains("amplitude") || urlScheme.hasPrefix("amp-") || urlScheme.hasPrefix("amplitude-") {
                        print("🔍 Detected Amplitude URL - handling with priority")
                        print("   🌐 URL: \(url)")
                        print("   📋 Scheme: \(urlScheme)")
                        let amplitudeHandled = analytics.handlePreviewURL(url)
                        if amplitudeHandled {
                            print("✅ Amplitude URL handled successfully")
                            return
                        }
                    }
                    
                    // Try custom URL router for wordguess:// schemes
                    let handled = urlRouter.handle(url)
                    
                    if !handled {
                        // Final fallback for any other Amplitude URLs we might have missed
                        let amplitudeHandled = analytics.handlePreviewURL(url)
                        print("🔗 URL handled by Amplitude fallback: \(amplitudeHandled)")
                    }
                }
                .alert("URL Navigation", isPresented: $urlRouter.showAlert) {
                    Button("OK") {
                        urlRouter.clearRoute()
                    }
                } message: {
                    Text(urlRouter.alertMessage)
                }
                .onAppear {
                    // Reset userId to null on each app open
                    analytics.setUserId(nil)
                    
                    // Print URL testing instructions on app launch
                    URLRouter.printTestingInstructions()
                }
        }
    }
}


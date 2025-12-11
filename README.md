# WordGuess iOS App 🎮

A fun word guessing game built with SwiftUI featuring adorable cat drawings, progressive difficulty, Amplitude analytics integration, and local leaderboard functionality.

![iOS](https://img.shields.io/badge/iOS-16.0%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![Xcode](https://img.shields.io/badge/Xcode-15.0%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## 📱 Features

- **5-Letter Word Gameplay**: Guess mystery 5-letter words with intelligent feedback
- **Progressive Cat Reveal**: Adorable cat illustration reveals progressively with each incorrect guess (up to 6 incorrect guesses)
- **Winner Celebration**: Cute celebratory cat appears when you win! 🎉
- **Smart Scoring System**: Points awarded based on guess number and letter position accuracy
  - 1st guess: 5 points per correct letter
  - 2nd guess: 4 points per correct letter
  - 3rd guess: 3 points per correct letter
  - 4th guess: 2 points per correct letter
  - 5th guess: 1 point per correct letter
  - Bonus: +5 points for completing the word
- **Leaderboard**: Local storage of high scores with player names
- **Amplitude Analytics**: Comprehensive user behavior tracking and engagement
- **Hint System**: Get up to 3 hints per game to reveal letters (with point deductions)
- **Modern UI**: Beautiful SwiftUI interface with smooth animations

## 🎯 Game Rules

1. **Start**: Begin a new game to get a random 5-letter mystery word
2. **Guess**: Enter a valid 5-letter word to see position-based feedback:
   - 🟢 **Green**: Letter is in the correct position
   - 🔴 **Red**: Letter is in the word but wrong position
   - ⚫ **Gray**: Letter is not in the word
3. **Cat Reveal**: Each incorrect guess reveals more of the cat (6 incorrect guesses max)
4. **Hints**: Use up to 3 hints to reveal letters:
   - 1st hint: -5 points
   - 2nd hint: -10 points
   - 3rd hint: -15 points
   - ⚠️ If a hint reveals the last letter, you lose!
5. **Win**: Complete the word before the cat is fully revealed
6. **Celebration**: Enjoy a cute kitten celebration when you win! 🐱✨
7. **Score**: Earn points based on guess efficiency and letter accuracy

## 🚀 Setup Instructions

### Prerequisites

- **macOS** with Xcode 15.0+ installed
- **iOS 16.0+** target device or simulator
- **Amplitude Account** (required for full functionality - free tier available)

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/t12t2/WordGuess.git
   cd WordGuess
   ```

2. **Open in Xcode**:
   ```bash
   open WordGuess.xcodeproj
   ```
   
   Or simply double-click `WordGuess.xcodeproj` in Finder

3. **Configure Amplitude Analytics** (Required for full functionality):

   **⚠️ Important**: The app requires an Amplitude API key to enable analytics tracking. Follow these steps:

   **Step 3a: Create an Amplitude Account** (if you don't have one)
   - Go to [amplitude.com](https://amplitude.com)
   - Click "**Get Started**" or "**Sign Up**"
   - Complete the registration process (free tier available)
   - Verify your email address

   **Step 3b: Create a New Project**
   - Log into your Amplitude dashboard
   - Click "**Create Project**" or go to Settings → Projects
   - Name your project (e.g., "WordGuess iOS")
   - Select the appropriate organization
   - Click "**Create Project**"

   **Step 3c: Get Your API Key**
   - In your Amplitude project dashboard
   - Go to **Settings** → **Projects** → Your Project Name
   - Copy your **API Key** (it will look like a long string of letters and numbers)
   - Example format: `a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6`

   **Step 3d: Add API Key to the App**
   
   Open `Analytics/AnalyticsManager.swift`:
   ```swift
   // Find this line (around line 14):
   let apiKey = "API_Key"
   
   // Replace "API_Key" with your actual Amplitude API key:
   let apiKey = "your_actual_api_key_here"
   ```

   **Step 3e: Configure URL Schemes for Amplitude Engagement**
   
   Open `Info.plist` (in Xcode, right-click → Open As → Source Code):
   ```xml
   <!-- Find these lines (around lines 34-35): -->
   <string>amplitude-API_Key</string>
   <string>amp-PROJECT_ID</string>
   
   <!-- Replace with your keys: -->
   <string>amplitude-your_actual_api_key_here</string>
   <string>amp-your_project_id_here</string>
   ```
   
   To find your Project ID:
   - In Amplitude dashboard, go to Settings → Projects
   - Copy the **Project ID** (shorter alphanumeric string)
   - Example: `a1b2c3d4e5`

   **📝 Note**: If you skip this step, the app will crash on launch. To run without Amplitude:
   - Comment out Amplitude initialization code in `AnalyticsManager.swift`
   - Or use dummy values (analytics won't work but app will run)

   **Step 3f: Set Up Guides & Surveys Preview (Optional but Recommended)**
   
   To preview Amplitude Guides and Surveys directly in your app, you need to add your project's unique URL scheme:
   
   **Find Your URL Scheme:**
   1. Go to [Amplitude Settings → Projects](https://amplitude.com)
   2. Select your project
   3. Click the **General** tab
   4. Find the **URL scheme (mobile)** field
   5. Copy the value (format: `amp-YOUR_PROJECT_ID`)
   6. Example: `amp-b6f1505eaa6344e4`
   
   **Add to Info.plist:**
   
   Open `Info.plist` in Xcode and find the Amplitude URL schemes section:
   ```xml
   <!-- Look for this section in Info.plist: -->
   <dict>
       <key>CFBundleURLName</key>
       <string>com.example.WordGuess.amplitude</string>
       <key>CFBundleURLSchemes</key>
       <array>
           <string>amplitude-your_actual_api_key_here</string>
           <string>amp-PROJECT_ID</string>  ← Replace this!
       </array>
   </dict>
   
   <!-- Replace amp-PROJECT_ID with your actual URL scheme: -->
   <string>amp-b6f1505eaa6344e4</string>
   ```
   
   **Why this matters:**
   - Enables preview mode for testing Guides and Surveys before going live
   - Allows you to see surveys in your app using preview links from Amplitude dashboard
   - Makes it easier to iterate on copy, targeting rules, and trigger logic
   
   **How to preview:**
   1. Create a survey or guide in Amplitude dashboard
   2. Click the **Preview** button
   3. Copy the preview URL (will start with your URL scheme)
   4. Open the URL on your simulator/device (or use: `xcrun simctl openurl booted "YOUR_PREVIEW_URL"`)
   5. The guide/survey will appear in your app!
   
   For more details, see [Amplitude's Preview Documentation](https://amplitude.com/docs/guides-and-surveys/guides-and-surveys-ios-sdk#simulate-guides-and-surveys-for-preview).

4. **Build and Run**:
   - Select a simulator or connected iOS device
   - Press `Cmd + R` to build and run the app

### Package Dependencies

The app uses Swift Package Manager for dependencies:
- **AmplitudeSwift**: Analytics SDK
- **Amplitude-iOS**: Session Replay
- **AmplitudeEngagementSwift**: Guides & Surveys

Dependencies are managed automatically by Xcode via Swift Package Manager.

## 📊 Analytics Events Tracked

The app tracks comprehensive user behavior with Amplitude:

### Events:
- **"game started"**: When user starts a new game
- **"letter guessed"**: Each letter guess with properties:
  - `letter`: The guessed letter
  - `is vowel`: Boolean indicating if it's a vowel
- **"full word guessed"**: When user guesses the complete word with metrics:
  - Total letters in secret word
  - Correct position letters count
  - Incorrect position letters count
- **"hint used"**: When player uses a hint
- **"game restarted"**: When user restarts the current game
- **"game ended"**: When game ends with property:
  - `win game`: Boolean indicating if user won

### User Properties:
- **"total guesses"**: Incremental counter tracking total guesses in current game
- **userId**: Set to player name when they win and enter their name
- **deviceId**: Unique identifier reset each game session

### Engagement Features:
- **Guides & Surveys**: Integrated Amplitude Engagement SDK
- **Session Replay**: User interaction recording for UX analysis

## 🗂 Project Structure

```
WordGuess/
├── WordGuessApp.swift        # App entry point
├── Info.plist               # Bundle configuration
├── Models/
│   ├── GameModel.swift       # Game logic and state management
│   ├── LeaderboardModel.swift # Score storage and leaderboard
│   └── URLRouter.swift       # Custom URL scheme handling
├── Views/
│   ├── ContentView.swift     # Main content view
│   ├── GameView.swift        # Primary game interface
│   ├── LeaderboardView.swift # High scores display
│   ├── CatDrawingView.swift  # Progressive cat reveal
│   └── CuteKittenView.swift  # Winner celebration kitten
├── Analytics/
│   └── AnalyticsManager.swift # Amplitude SDK integration
└── Assets.xcassets/          # App icons, colors, and images
    ├── cat-lying-down2.imageset/
    └── happy_cat.imageset/
```

## 🛠 Technical Details

- **Framework**: SwiftUI with iOS 16.0+ deployment target
- **Architecture**: MVVM pattern with ObservableObject models
- **Dependencies**: AmplitudeSwift SDK via Swift Package Manager
- **Storage**: UserDefaults for local leaderboard persistence
- **Drawing**: SwiftUI GeometryReader and masking for progressive image reveal
- **URL Schemes**: Custom `wordguess://` scheme for deep linking
- **Word List**: 500 secret words and 5,757 valid words from curated 5-letter word lists

## 🎨 Customization

- **Word List**: Modify the `secretWords` and `validWords` arrays in `Models/GameModel.swift`
- **Scoring**: Adjust scoring logic in the `guessWord()` method in `GameModel.swift`
- **UI Styling**: Update colors, fonts, and layouts in the view files
- **Analytics**: Add more events or properties in `Analytics/AnalyticsManager.swift`
- **Cat Images**: Replace images in `Assets.xcassets/` with your own

## 🧪 Testing

### Running in Simulator

1. Open Xcode
2. Select "iPhone 15" or any iOS 16+ simulator
3. Build and run with `Cmd + R`
4. The app will launch in the simulator

### Testing URL Schemes

Test deep linking with:
```bash
# Open game screen
xcrun simctl openurl booted "wordguess://game"

# Start new game
xcrun simctl openurl booted "wordguess://game/new"

# Open leaderboard
xcrun simctl openurl booted "wordguess://leaderboard"
```

### Testing Amplitude Guides & Surveys Preview

To test Guides and Surveys in your app before publishing:

**Prerequisites:**
- You've completed Step 3f (added your project's URL scheme to Info.plist)
- You have a guide or survey created in your Amplitude dashboard

**Method 1: From Amplitude Dashboard**
1. In Amplitude, go to your guide or survey
2. Click the **Preview** button
3. Copy the preview URL (format: `amp-YOUR_PROJECT_ID://preview?...`)
4. Use Terminal to open it in your simulator:
   ```bash
   xcrun simctl openurl booted "amp-YOUR_PROJECT_ID://preview?surveyId=YOUR_SURVEY_ID"
   ```
   Replace `YOUR_PROJECT_ID` with your actual project ID (e.g., `amp-b6f1505eaa6344e4`)

**Method 2: On Physical Device**
1. Email yourself the preview URL from Amplitude dashboard
2. Open the email on your iOS device
3. Tap the preview link
4. Your app will open with the guide/survey displayed!

**What You'll See:**
- The guide or survey appears immediately in your app
- Ignores targeting rules (shows regardless of conditions)
- Perfect for testing copy, design, and user flow
- Responses are marked as "Preview" in Amplitude

For more information, see the [Amplitude Preview Documentation](https://amplitude.com/docs/guides-and-surveys/guides-and-surveys-ios-sdk#simulate-guides-and-surveys-for-preview).

## 🐛 Troubleshooting

### Build Errors
- Ensure Xcode 15+ and iOS 16+ deployment target
- Clean build folder: `Cmd + Shift + K`
- Rebuild: `Cmd + B`

### Package Dependencies
If AmplitudeSwift fails to load:
1. Go to **Product** → **Package Dependencies** → **Reset Package Caches**
2. Clean and rebuild the project

### App Crashes on Launch
**Most likely cause**: Missing or invalid Amplitude API key

**Solution**:
1. Check `Analytics/AnalyticsManager.swift` - make sure you replaced `"API_Key"` with your actual key
2. Verify your API key is correct (copy it again from Amplitude dashboard)
3. Check Xcode console for error messages related to Amplitude initialization

**Temporary workaround** (to test app without Amplitude):
```swift
// In AnalyticsManager.swift, comment out Amplitude initialization:
// self.amplitude = Amplitude(configuration: configuration)
```

### Analytics Not Working
- **API Key Issues**:
  - Ensure you replaced `"API_Key"` with your actual Amplitude API key in `AnalyticsManager.swift`
  - Verify the key is copied correctly (no extra spaces or quotes)
  - Check that the key is for the correct Amplitude project
  
- **URL Scheme Issues**:
  - Open `Info.plist` and verify:
    - `amplitude-API_Key` is replaced with `amplitude-your_actual_api_key`
    - `amp-PROJECT_ID` is replaced with `amp-your_actual_project_id`
  - Get your Project ID from Amplitude Settings → Projects
  
- **Network & Permissions**:
  - Verify network permissions in simulator/device settings
  - Check firewall settings aren't blocking Amplitude
  - Ensure you're connected to the internet
  
- **Verification**:
  - Check Xcode console for messages like:
    - ✅ `"Amplitude initialized"` 
    - ✅ `"Guides and Surveys SDK initialized"`
  - Go to Amplitude dashboard → Real-time → Should see events appearing
  - Events may take 1-2 minutes to appear in dashboard

### Images Not Showing
- Ensure images are properly added to `Assets.xcassets`
- Verify image names match exactly (case-sensitive)
- Clean and rebuild the project

## 📜 License

This project is available under the MIT License.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/YOUR_USERNAME/WordGuess/issues).

## 👏 Acknowledgments

- Word lists sourced from:
  - [Wordle word list by slushman](https://gist.github.com/slushman/34e60d6bc479ac8fc698df8c226e4264)
  - [5-Letter words by darkermango](https://darkermango.github.io/5-Letter-words/words.json)
- Built with [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- Analytics powered by [Amplitude](https://amplitude.com)

---

**Enjoy playing WordGuess! 🎮🐱✨**

Made with ❤️ in Swift

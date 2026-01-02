import SwiftUI

struct GameView: View {
    @StateObject private var game = GameModel()
    @EnvironmentObject var analytics: AnalyticsManager
    @EnvironmentObject var urlRouter: URLRouter
    @StateObject private var leaderboard = LeaderboardModel()
    
    @State private var inputText = ""
    @State private var showingWinAlert = false
    @State private var showingLoseAlert = false
    @State private var showingEndGameAlert = false
    @State private var showingHappyCat = false
    @State private var winnerName = ""
    @State private var showingLeaderboard = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title
                Text("Word Guess")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                if game.gameState == .waiting {
                    // Start screen
                    VStack(spacing: 30) {
                        Text("Welcome to Word Guess!")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                        
                        Text("Guess the mystery word before the cat is fully drawn!")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button("Start Game") {
                            game.startNewGame()
                            analytics.trackGameStarted()
                        }
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .accessibilityIdentifier("StartGameButton")
                        
                        Button("View Leaderboard") {
                            showingLeaderboard = true
                            analytics.trackScreen("LeaderboardScreen")
                        }
                        .font(.title3)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .accessibilityIdentifier("ViewLeaderboardButton")
                    }
                    .padding()
                } else {
                    // Game screen
                    VStack(spacing: 0) {
                        // Score and guesses info
                        HStack {
                            Text("Score: \(max(0, game.score))")
                                .font(.headline)
                            Spacer()
                            Text("Guesses: \(game.guessCount)/6")
                                .font(.headline)
                            Spacer()
                            Text("Wrong: \(game.incorrectGuesses)/6")
                                .font(.headline)
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                        // Scrollable content area
                        ScrollView {
                            VStack(spacing: 10) {
                                // Cat drawing (only during gameplay)
                                if game.gameState != .won {
                                    CatDrawingView(incorrectGuesses: game.incorrectGuesses)
                                        .frame(height: 140)
                                }
                                
                                // Word display
                                Text(game.displayWord)
                                    .font(.system(size: 24).monospaced())
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                
                                // Word guesses feedback (only show first 5 guesses)
                                if !game.wordFeedback.isEmpty {
                                    VStack(spacing: 8) {
                                        Text("Previous Guesses:")
                                            .font(.headline)
                                            .padding(.top, 5)
                                        
                                        ForEach(0..<min(5, game.wordFeedback.count), id: \.self) { guessIndex in
                                            HStack(spacing: 4) {
                                                ForEach(0..<game.wordFeedback[guessIndex].count, id: \.self) { letterIndex in
                                                    let letterPos = game.wordFeedback[guessIndex][letterIndex]
                                                    Text(String(letterPos.letter))
                                                        .font(.system(size: 18, weight: .bold))
                                                        .frame(width: 30, height: 30)
                                                        .background(colorForLetterState(letterPos.state))
                                                        .foregroundColor(.white)
                                                        .cornerRadius(6)
                                                }
                                                
                                                Spacer()
                                                
                                                Text(game.wordGuesses[guessIndex])
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                
                                // Error message
                                if !game.errorMessage.isEmpty {
                                    Text(game.errorMessage)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.bottom, 10)
                        }
                        
                        // Fixed bottom section - always visible
                        VStack(spacing: 15) {
                            Divider()
                            
                            // Input section
                            VStack(spacing: 15) {
                                TextField("Enter your word guess", text: $inputText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.allCharacters)
                                    .disableAutocorrection(true)
                                    .accessibilityIdentifier("WordInputField")
                                
                                HStack(spacing: 10) {
                                    Button("Guess Word") {
                                        guessWord()
                                    }
                                    .disabled(inputText.isEmpty)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(inputText.isEmpty ? Color.gray : Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .accessibilityIdentifier("GuessWordButton")
                                    
                                    Button("Hint (\(game.hintsUsed)/3)") {
                                        // Track hint requested event (nth hint about to be used)
                                        let hintCount = game.hintsUsed + 1
                                        let penalty = hintCount == 1 ? -10 : (hintCount == 2 ? -15 : -20)
                                        print("🎯 Hint button pressed: About to use hint #\(hintCount) with penalty \(penalty)")
                                        print("🎯 Current game state: \(game.gameState), Current score: \(game.score)")
                                        analytics.trackHintRequested(hintCount: hintCount, pointPenalty: penalty)
                                        game.useHint()
                                        print("🎯 After useHint(): hintsUsed = \(game.hintsUsed), score = \(game.score)")
                                    }
                                    .disabled(game.hintsUsed >= 3)
                                    .padding()
                                    .background(game.hintsUsed >= 3 ? Color.gray : Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .accessibilityIdentifier("HintButton")
                                }
                            }
                            .padding(.horizontal)
                            
                            // Game control buttons - always visible
                            HStack(spacing: 20) {
                                Button("Restart Game") {
                                    game.restartGame()
                                    analytics.trackGameRestarted()
                                    inputText = ""
                                }
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                
                                Button("End Game") {
                                    showingEndGameAlert = true
                                }
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                        .padding(.bottom, 10)
                        .background(Color(UIColor.systemBackground))
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onChange(of: game.gameState) { state in
            if state == .won {
                showingHappyCat = true
            } else if state == .lost {
                showingLoseAlert = true
            }
        }
        .overlay(
            // Happy cat celebration overlay when user wins
            Group {
                if showingHappyCat {
                    ZStack {
                        Color.black.opacity(0.8)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 20) {
                            Text("🎉 YOU WON! 🎉")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Image("happy_cat")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 300, maxHeight: 300)
                                .cornerRadius(20)
                            
                            Text("Tap to continue")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                    }
                    .onTapGesture {
                        showingHappyCat = false
                        showingWinAlert = true
                    }
                    .transition(.opacity)
                    .animation(.easeInOut, value: showingHappyCat)
                }
            }
        )
        .alert("You Won! 🎉", isPresented: $showingWinAlert) {
            TextField("Enter your name", text: $winnerName)
            Button("Save Score") {
                if !winnerName.isEmpty {
                    analytics.setUserIdFromName(winnerName)
                    let finalScore = max(0, game.score)
                    leaderboard.addScore(name: winnerName, score: finalScore, word: game.currentWord, guesses: game.guessCount)
                }
                analytics.trackGameEnded(didWin: true, didGameComplete: true)
                game.endGame()
                winnerName = ""
                inputText = ""
                showingLeaderboard = true
            }
            Button("Skip") {
                analytics.trackGameEnded(didWin: true, didGameComplete: true)
                game.endGame()
                inputText = ""
                showingLeaderboard = true
            }
        } message: {
            Text("Congratulations! You guessed '\(game.currentWord)' with a score of \(max(0, game.score)) points!")
        }
        .alert("Game Over 😞", isPresented: $showingLoseAlert) {
            Button("OK") {
                analytics.trackGameEnded(didWin: false, didGameComplete: true)
                game.endGame()
                inputText = ""
                showingLeaderboard = true
            }
        } message: {
            Text("The word was '\(game.currentWord)'. Better luck next time!")
        }
        .alert("Game Ended 🐱", isPresented: $showingEndGameAlert) {
            Button("OK") {
                analytics.trackGameEnded(didWin: false, didGameComplete: false)
                game.endGame()
                inputText = ""
                showingLeaderboard = true
            }
        } message: {
            Text("The word was '\(game.currentWord)'. Thanks for playing Word Guess!")
        }
        .sheet(isPresented: $showingLeaderboard) {
            LeaderboardView(leaderboard: leaderboard, onStartNewGame: {
                showingLeaderboard = false
                game.startNewGame()
                analytics.trackGameStarted()
            })
        }
        .onReceive(NotificationCenter.default.publisher(for: .startNewGameFromURL)) { _ in
            print("🔗 Starting new game from URL")
            if game.gameState != .waiting {
                game.endGame()
            }
            game.startNewGame()
            analytics.trackGameStarted()
        }
        .onReceive(NotificationCenter.default.publisher(for: .startGameWithWord)) { notification in
            if let word = notification.object as? String {
                print("🔗 URL requested game with word: \(word) (starting random game instead)")
                if game.gameState != .waiting {
                    game.endGame()
                }
                // Start a regular new game (setting specific words would make game too easy)
                game.startNewGame()
                analytics.trackGameStarted()
                
                // Show a message about the URL
                urlRouter.alertMessage = "Game started! (Requested word: \(word))"
                urlRouter.showAlert = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .showLeaderboardFromURL)) { _ in
            print("🔗 Showing leaderboard from URL")
            showingLeaderboard = true
        }
    }
    
    private func guessWord() {
        guard !inputText.isEmpty else { return }
        
        let result = game.guessWord(inputText)
        
        // Track analytics based on whether the word was valid
        if result.isValid {
            analytics.trackWordGuessed(
                word: inputText.uppercased(),
                lettersInSecretWordCount: game.currentWord.count,
                correctPositionLettersCount: result.correctPositions,
                incorrectPositionLettersCount: result.wrongPositions
            )
        } else {
            // Track error when word is invalid
            analytics.trackErrorEncountered(
                invalidWord: inputText.uppercased(),
                errorMessage: game.errorMessage
            )
        }
        
        inputText = ""
    }
    
    private func colorForLetterState(_ state: LetterState) -> Color {
        switch state {
        case .correctPosition:
            return .green
        case .wrongPosition:
            return .red
        case .notInWord:
            return .gray
        case .unknown:
            return .gray
        }
    }
}


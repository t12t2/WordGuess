import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var leaderboard: LeaderboardModel
    let onStartNewGame: () -> Void
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var analytics: AnalyticsManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("🏆 Leaderboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                if leaderboard.scores.isEmpty {
                    VStack(spacing: 20) {
                        Text("No scores yet!")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        Text("Play a game and win to see your score here!")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else {
                    List {
                        ForEach(Array(leaderboard.scores.enumerated()), id: \.element.id) { index, score in
                            HStack {
                                // Rank
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(rankColor(for: index))
                                    .frame(width: 30)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    // Name and score
                                    HStack {
                                        Text(score.name)
                                            .font(.headline)
                                        Spacer()
                                        Text("\(score.score) pts")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.blue)
                                    }
                                    
                                    // Word and details
                                    HStack {
                                        Text("Word: \(score.word)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Text("\(score.guesses) guesses")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    // Date
                                    Text(formatDate(score.date))
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                
                                // Trophy for top 3
                                if index < 3 {
                                    Text(trophyEmoji(for: index))
                                        .font(.title2)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Spacer()
                
                // Action buttons
                VStack(spacing: 15) {
                    Button("Start New Game") {
                        analytics.setUserId(nil)
                        onStartNewGame()
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Close") {
                        analytics.setUserId(nil)
                        dismiss()
                    }
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    if !leaderboard.scores.isEmpty {
                        Button("Clear Scores") {
                            leaderboard.clearScores()
                        }
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
    
    private func rankColor(for index: Int) -> Color {
        switch index {
        case 0: return .yellow // Gold
        case 1: return .gray   // Silver
        case 2: return .brown  // Bronze
        default: return .primary
        }
    }
    
    private func trophyEmoji(for index: Int) -> String {
        switch index {
        case 0: return "🥇"
        case 1: return "🥈"
        case 2: return "🥉"
        default: return ""
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


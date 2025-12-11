import Foundation

struct ScoreEntry: Codable, Identifiable {
    let id = UUID()
    let name: String
    let score: Int
    let date: Date
    let word: String
    let guesses: Int
    
    init(name: String, score: Int, word: String, guesses: Int) {
        self.name = name
        self.score = score
        self.date = Date()
        self.word = word
        self.guesses = guesses
    }
}

class LeaderboardModel: ObservableObject {
    @Published var scores: [ScoreEntry] = []
    private let userDefaults = UserDefaults.standard
    private let scoresKey = "HangmanScores"
    
    init() {
        loadScores()
    }
    
    func addScore(name: String, score: Int, word: String, guesses: Int) {
        let newScore = ScoreEntry(name: name, score: score, word: word, guesses: guesses)
        scores.append(newScore)
        scores.sort { $0.score > $1.score } // Sort by highest score first
        
        // Keep only top 10 scores
        if scores.count > 10 {
            scores = Array(scores.prefix(10))
        }
        
        saveScores()
    }
    
    func getRanking(for score: Int) -> Int {
        let sortedScores = scores.sorted { $0.score > $1.score }
        if let index = sortedScores.firstIndex(where: { $0.score <= score }) {
            return index + 1
        }
        return scores.count + 1
    }
    
    private func saveScores() {
        if let encoded = try? JSONEncoder().encode(scores) {
            userDefaults.set(encoded, forKey: scoresKey)
        }
    }
    
    private func loadScores() {
        if let data = userDefaults.data(forKey: scoresKey),
           let decodedScores = try? JSONDecoder().decode([ScoreEntry].self, from: data) {
            scores = decodedScores
        }
    }
    
    func clearScores() {
        scores.removeAll()
        userDefaults.removeObject(forKey: scoresKey)
    }
}


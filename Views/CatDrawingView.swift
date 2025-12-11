import SwiftUI

struct CatDrawingView: View {
    let incorrectGuesses: Int
    
    var body: some View {
        GeometryReader { geometry in
            // Use the cat image and reveal it progressively from left to right
            Image("cat-lying-down2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .mask(
                    // Progressive reveal mask from left to right
                    HStack(spacing: 0) {
                        // Revealed portion (left side)
                        Rectangle()
                        .fill(Color.white)
                            .frame(width: geometry.size.width * revealPercentage)
                        
                        // Hidden portion (right side)
                        Spacer()
                    }
                )
        }
        .frame(height: 140)
        .onAppear {
            print("🐱 CatDrawingView loaded. Incorrect guesses: \(incorrectGuesses), Reveal: \(Int(revealPercentage * 100))%")
        }
        .onChange(of: incorrectGuesses) { newValue in
            print("🐱 Incorrect guesses changed to: \(newValue), Reveal: \(Int(revealPercentage * 100))%")
                        }
    }
    
    // Calculate reveal percentage based on incorrect guesses
    private var revealPercentage: CGFloat {
        switch incorrectGuesses {
        case 0:
            return 0.0      // 0% - Nothing revealed
        case 1:
            return 0.167    // 16.7% - 1/6 revealed (eyes area)
        case 2:
            return 0.333    // 33.3% - 2/6 revealed (+ ears)
        case 3:
            return 0.5      // 50% - 3/6 revealed (+ head complete)
        case 4:
            return 0.667    // 66.7% - 4/6 revealed (+ body starts)
        case 5:
            return 0.833    // 83.3% - 5/6 revealed (+ most of body)
        default:
            return 1.0      // 100% - Fully revealed (+ tail)
    }
}
}

import SwiftUI

struct CuteKittenView: View {
    var body: some View {
        ZStack {
            // Realistic winner kitten - matching the reference style but happy
            Group {
                // Kitten's head - realistic oval shape
                Path { path in
                    path.addEllipse(in: CGRect(x: 105, y: 75, width: 90, height: 85))
                }
                .stroke(Color.black, lineWidth: 2.5)
                
                // Kitten ears with inner details - realistic triangular shape
                Group {
                    // Left ear outline
                    Path { path in
                        path.move(to: CGPoint(x: 125, y: 82))
                        path.addLine(to: CGPoint(x: 115, y: 45))
                        path.addLine(to: CGPoint(x: 145, y: 65))
                        path.closeSubpath()
                    }
                    .stroke(Color.black, lineWidth: 2.5)
                    
                    // Left ear inner detail (pink)
                    Path { path in
                        path.move(to: CGPoint(x: 130, y: 75))
                        path.addLine(to: CGPoint(x: 123, y: 58))
                        path.addLine(to: CGPoint(x: 138, y: 68))
                        path.closeSubpath()
                    }
                    .fill(Color.pink.opacity(0.7))
                    
                    // Right ear outline
                    Path { path in
                        path.move(to: CGPoint(x: 175, y: 82))
                        path.addLine(to: CGPoint(x: 185, y: 45))
                        path.addLine(to: CGPoint(x: 155, y: 65))
                        path.closeSubpath()
                    }
                    .stroke(Color.black, lineWidth: 2.5)
                    
                    // Right ear inner detail (pink)
                    Path { path in
                        path.move(to: CGPoint(x: 170, y: 75))
                        path.addLine(to: CGPoint(x: 177, y: 58))
                        path.addLine(to: CGPoint(x: 162, y: 68))
                        path.closeSubpath()
                    }
                    .fill(Color.pink.opacity(0.7))
                }
                
                // Happy sparkling eyes - round and bright
                Group {
                    // Left eye
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .position(x: 135, y: 110)
                    
                    // Left eye sparkle
                    Circle()
                        .fill(Color.white)
                        .frame(width: 6, height: 6)
                        .position(x: 138, y: 107)
                    
                    // Left eye smaller sparkle
                    Circle()
                        .fill(Color.white)
                        .frame(width: 2, height: 2)
                        .position(x: 132, y: 112)
                    
                    // Right eye
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .position(x: 165, y: 110)
                    
                    // Right eye sparkle
                    Circle()
                        .fill(Color.white)
                        .frame(width: 6, height: 6)
                        .position(x: 168, y: 107)
                    
                    // Right eye smaller sparkle
                    Circle()
                        .fill(Color.white)
                        .frame(width: 2, height: 2)
                        .position(x: 162, y: 112)
                }
                
                // Nose and facial features
                Group {
                    // Nose (realistic triangle)
                    Path { path in
                        path.move(to: CGPoint(x: 150, y: 125))
                        path.addLine(to: CGPoint(x: 147, y: 132))
                        path.addLine(to: CGPoint(x: 153, y: 132))
                        path.closeSubpath()
                    }
                    .fill(Color.pink)
                    
                    // Nose line
                    Path { path in
                        path.move(to: CGPoint(x: 150, y: 132))
                        path.addLine(to: CGPoint(x: 150, y: 140))
                    }
                    .stroke(Color.black, lineWidth: 1.5)
                    
                    // Happy smile
                    Path { path in
                        path.addArc(center: CGPoint(x: 150, y: 145),
                                   radius: 10,
                                   startAngle: .degrees(0),
                                   endAngle: .degrees(180),
                                   clockwise: true)
                    }
                    .stroke(Color.black, lineWidth: 2)
                }
                
                // Perky whiskers
                Group {
                    // Left whiskers
                    Path { path in
                        path.move(to: CGPoint(x: 90, y: 118))
                        path.addLine(to: CGPoint(x: 120, y: 123))
                    }
                    .stroke(Color.black, lineWidth: 1.2)
                    
                    Path { path in
                        path.move(to: CGPoint(x: 93, y: 128))
                        path.addLine(to: CGPoint(x: 120, y: 130))
                    }
                    .stroke(Color.black, lineWidth: 1.2)
                    
                    Path { path in
                        path.move(to: CGPoint(x: 95, y: 138))
                        path.addLine(to: CGPoint(x: 120, y: 137))
                    }
                    .stroke(Color.black, lineWidth: 1.2)
                    
                    // Right whiskers
                    Path { path in
                        path.move(to: CGPoint(x: 180, y: 123))
                        path.addLine(to: CGPoint(x: 210, y: 118))
                    }
                    .stroke(Color.black, lineWidth: 1.2)
                    
                    Path { path in
                        path.move(to: CGPoint(x: 180, y: 130))
                        path.addLine(to: CGPoint(x: 207, y: 128))
                    }
                    .stroke(Color.black, lineWidth: 1.2)
                    
                    Path { path in
                        path.move(to: CGPoint(x: 180, y: 137))
                        path.addLine(to: CGPoint(x: 205, y: 138))
                    }
                    .stroke(Color.black, lineWidth: 1.2)
                }
                
                // Kitten body - sitting position like reference
                Path { path in
                    path.move(to: CGPoint(x: 125, y: 160))
                    path.addQuadCurve(to: CGPoint(x: 110, y: 205), control: CGPoint(x: 115, y: 180))
                    path.addQuadCurve(to: CGPoint(x: 120, y: 250), control: CGPoint(x: 108, y: 230))
                    path.addLine(to: CGPoint(x: 180, y: 250))
                    path.addQuadCurve(to: CGPoint(x: 190, y: 205), control: CGPoint(x: 192, y: 230))
                    path.addQuadCurve(to: CGPoint(x: 175, y: 160), control: CGPoint(x: 185, y: 180))
                    path.closeSubpath()
                }
                .stroke(Color.black, lineWidth: 2.5)
                
                // Front legs
                Group {
                    // Left front leg
                    Path { path in
                        path.move(to: CGPoint(x: 130, y: 240))
                        path.addLine(to: CGPoint(x: 130, y: 275))
                        path.addLine(to: CGPoint(x: 138, y: 280))
                        path.addLine(to: CGPoint(x: 125, y: 280))
                        path.addLine(to: CGPoint(x: 125, y: 275))
                    }
                    .stroke(Color.black, lineWidth: 2)
                    
                    // Right front leg
                    Path { path in
                        path.move(to: CGPoint(x: 170, y: 240))
                        path.addLine(to: CGPoint(x: 170, y: 275))
                        path.addLine(to: CGPoint(x: 178, y: 280))
                        path.addLine(to: CGPoint(x: 165, y: 280))
                        path.addLine(to: CGPoint(x: 165, y: 275))
                    }
                    .stroke(Color.black, lineWidth: 2)
                }
                
                // Hind legs (partially visible)
                Group {
                    // Left hind leg
                    Path { path in
                        path.move(to: CGPoint(x: 125, y: 230))
                        path.addQuadCurve(to: CGPoint(x: 115, y: 265), control: CGPoint(x: 118, y: 250))
                        path.addLine(to: CGPoint(x: 125, y: 270))
                    }
                    .stroke(Color.black, lineWidth: 2)
                    
                    // Right hind leg
                    Path { path in
                        path.move(to: CGPoint(x: 175, y: 230))
                        path.addQuadCurve(to: CGPoint(x: 185, y: 265), control: CGPoint(x: 182, y: 250))
                        path.addLine(to: CGPoint(x: 175, y: 270))
                    }
                    .stroke(Color.black, lineWidth: 2)
                }
                
                // Happy upright tail
                Path { path in
                    path.move(to: CGPoint(x: 185, y: 200))
                    path.addQuadCurve(to: CGPoint(x: 220, y: 155), 
                                    control: CGPoint(x: 210, y: 175))
                    path.addQuadCurve(to: CGPoint(x: 235, y: 105),
                                    control: CGPoint(x: 235, y: 130))
                    path.addQuadCurve(to: CGPoint(x: 225, y: 65),
                                    control: CGPoint(x: 240, y: 85))
                }
                .stroke(Color.black, lineWidth: 3)
                
                // Celebration elements
                Group {
                    // Sparkles around the kitten
                    Text("✨")
                        .font(.title)
                        .position(x: 70, y: 70)
                    
                    Text("⭐")
                        .font(.title2)
                        .position(x: 230, y: 60)
                    
                    Text("✨")
                        .font(.title3)
                        .position(x: 250, y: 140)
                    
                    Text("⭐")
                        .font(.title2)
                        .position(x: 50, y: 170)
                    
                    Text("🎉")
                        .font(.title)
                        .position(x: 85, y: 130)
                    
                    Text("🎊")
                        .font(.title2)
                        .position(x: 215, y: 125)
                    
                    // Hearts for extra celebration
                    Text("💕")
                        .font(.title3)
                        .position(x: 60, y: 220)
                    
                    Text("💖")
                        .font(.title3)
                        .position(x: 240, y: 200)
                }
            }
        }
        .frame(width: 300, height: 320)
    }
}

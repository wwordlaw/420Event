// //
// //  ContentView.swift
// //  Maps
// //
// //  Created by dj on 3/26/25.


// import SwiftUI

// struct HomePage: View {
//     var body: some View {
        
//         ZStack {
//             LinearGradient(colors: [.lightPink, .lightPurple],
//         startPoint: .top,
//         endPoint: .center)
//             ScrollView{
//                 VStack {
//                     Image("highLogo")
//                         .resizable()
//                         .scaledToFit()
//                         .frame(width: 300, height: 300)
//                     Image("eggsCluster")
//                         .resizable()
//                         .scaledToFit()
                    
// //                    ScrollView(.horizontal, showsIndicators: false){
// //                        HStack{
// //                            
// //                            Image("flyerFront")
// //                                .resizable()
// //                                .scaledToFit()
// //                            Image("flyerBack")
// //                                .resizable()
// //                                .scaledToFit()
// //                        }
// //                        .frame(width: 800, height: 300)
// //                    }
                    
//                 }
//             }
//         }
//         .ignoresSafeArea()
//     }
// }

// #Preview {
//     HomePage()
// }





import SwiftUI
import Foundation // Needed for GradientButton

// MARK: - Minimal Style Guide Definitions (Place appropriately)

extension Color {
//    // Placeholders - DEFINE THESE PROPERLY!
//    static let lightPink = Color.pink.opacity(0.6)
//    static let lightSage = Color.green.opacity(0.6)
//    static let lightPurple = Color.purple.opacity(0.6)
//    static let azul = Color.blue

    // Hex Initializer
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted); var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int); let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:(a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
    // From Style Guide for Background
     static let eggHuntPink = Color(hex: "#F4C5C3")
     static let eggHuntLavender = Color(hex: "#D5D0FF")
}

extension LinearGradient {
    static var mainBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.eggHuntPink, .eggHuntLavender]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

extension Font {
     // Custom Font reference (ensure font file is in project & Info.plist)
     static func sfCompactRegular(size: CGFloat) -> Font {
         return .custom("SF COMPACT REGULAR", size: size)
     }
    // Placeholder for body if not defined elsewhere
    static let body = Font.system(size: 17)
}


// MARK: - Gradient Button Definition

struct GradientButton: View {
    let gradientColors = Gradient(colors: [.lightPink, .lightSage, .lightPurple]) // Use actual colors
    var title: String
    @State private var isPressed = false
    @State private var isAnimating = false
    var action: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(AngularGradient.init(gradient: gradientColors, center: .center, angle: .degrees(isAnimating ? 360 : 0)), lineWidth: 14)
                .frame(width: 210, height: 30)
                .offset(y: 30)
                .blur(radius: 30)

            Text(title)
                .font(.sfCompactRegular(size: 30)) // Use custom font
                .foregroundColor(.azul) // Use actual color
                .frame(width: 280, height: 60)
                .background(.white, in: RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(AngularGradient.init(gradient: gradientColors, center: .center, angle: .degrees(isAnimating ? 360 : 0)), lineWidth: 3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 4)
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear,.clear, .clear]), startPoint: .top, endPoint: .bottom))
                        }
                }
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(.easeOut(duration: 0.2), value: isPressed)
        .onAppear {
            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        }
        .onTapGesture { action() } // Trigger action
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in isPressed = true })
                .onEnded({ _ in isPressed = false })
        )
    }
}


// MARK: - Updated Home Page View

import SwiftUI
import Foundation


struct HomePage: View {
    var switchToHelpTab: () -> Void

    var body: some View {
        ZStack {
            LinearGradient.mainBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    Spacer().frame(height: 50) // Adjust top padding

                    Image("highLogo") // Ensure asset exists
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding(.bottom, -80)

                    Image("eggsCluster") // Ensure asset exists
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 20)
                        .padding(.bottom, -60)

                    // --- Add GradientButton back ---
                    GradientButton(title: "How to Play?") {
                        // Execute the closure passed from ContentView
                        print("HomePage button tapped, calling switchToHelpTab closure.")
                        switchToHelpTab()
                    }


                }
            }
        }
    }
}

#Preview {
    HomePage(switchToHelpTab: { print("Preview: Switch to Help Tapped") })
}


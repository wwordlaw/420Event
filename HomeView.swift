// HomeView.swift

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            // 1. Background Gradient from Style Guide
            LinearGradient.mainBackground
                .ignoresSafeArea()

            // 2. Main Vertical Layout
            VStack(spacing: 0) {

                // Spacer to push content down from the status bar slightly
                Spacer().frame(height: 30)

                // 3. Logo Image (Requires "highRebirthLogo" in Assets)
                Image("highRebirthLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)

                // 4. Egg Group Image (Requires "eggsCluster" in Assets)
                //    (Note: You changed the name from eggGroupImage to eggsCluster in your code)
                Image("eggsCluster")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
                    // Add some spacing below the image before the button
                    .padding(.bottom, 40) // Adjusted spacing

                // 5. Begin Hunt Button (NEW)
                Button {
                    // --- TODO: Add Action for Begin Hunt ---
                    print("Begin Hunt button tapped!")
                    // Example: Navigate to the game screen
                    // --- End TODO ---
                } label: {
                    Text("Begin Hunt")
                        // Use body font from style guide, adjust if needed
                        .font(Font.body ?? .body)
                        .fontWeight(.medium) // Make it slightly bolder
                        .foregroundColor(.white) // White text for contrast
                        // Internal padding for text inside the button
                        .padding(.vertical, 12)
                        .padding(.horizontal, 40)
                        // Background color using style guide Olive
                        .background(Color.eggHuntOlive)
                        // Make it capsule shaped
                        .clipShape(Capsule())
                }
                // Add horizontal padding to control the button's width
                .padding(.horizontal, 50)
                 // Add padding below the button before the spacer
                .padding(.bottom, 30)


                // Spacer pushes content above the bottom bar
                Spacer()
//
//                // 6. Bottom Navigation Bar Area (was step 5)
//                BottomNavBar()
//                    .padding(.bottom, 5)
            }
        }
    }
}

//// MARK: - Bottom Navigation Bar Component
//struct BottomNavBar: View {
//    // ... (rest of BottomNavBar struct remains the same)
//    var body: some View {
//        HStack {
//            Spacer()
//            NavButton(iconName: "map")
//            Spacer()
//            NavButton(iconName: "list.bullet")
//            Spacer()
//            NavButton(iconName: "house")
//            Spacer()
//            NavButton(iconName: "questionmark.circle", label: "List")
//            Spacer()
//        }
//        .padding(.horizontal)
//        .padding(.vertical, 10)
//        // .background(.ultraThinMaterial) // Optional background
//    }
//}

// MARK: - Reusable Navigation Button
struct NavButton: View {
    // ... (rest of NavButton struct remains the same)
    let iconName: String
    var label: String? = nil
    @State private var isTapped = false

    var body: some View {
        Button {
            print("\(label ?? iconName) button tapped")
        } label: {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.system(size: 24, weight: .regular))
                    .frame(height: 28)

                if let label = label, !label.isEmpty {
                    Text(label)
                        .font(Font.caption ?? .caption)
                        .lineLimit(1)
                }
            }
            .foregroundColor(.mainText)
            .scaleEffect(isTapped ? 0.95 : 1.0)
            .opacity(isTapped ? 0.8 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isTapped)
        }
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            isTapped = pressing
        }, perform: {})
    }
}

// MARK: - Preview Provider
#Preview {
    HomeView()
}

// MARK: - Required Assets
/*
 Add the following images to your Assets.xcassets:
 1. highRebirthLogo
 2. eggsCluster // Updated name based on your code
*/

// MARK: - StyleGuide Dependency
/*
 Relies on definitions from your StyleGuide setup (Colors, Gradients, Fonts).
 This code uses Color.eggHuntOlive for the button background and Color.white for text.
 Ensure Font.body and Font.caption are defined in your StyleGuide setup.
*/

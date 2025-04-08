// InstructionsView.swift

import SwiftUI

// MARK: - Data Structure for Instructions
struct InstructionItem: Identifiable {
    let id = UUID()
    let eggAssetName: String // Name of the egg image asset
    let text: String         // Instruction text
}

// MARK: - Main View
struct InstructionsView: View {

    // --- Data Source ---
    // Populate this array with your actual instruction steps
    // Ensure the eggAssetName matches the names in your Assets.xcassets
    let instructions: [InstructionItem] = [
        InstructionItem(eggAssetName: "eggPinkPattern", text: "Open the app & check your first clue"),
        InstructionItem(eggAssetName: "eggBlue", text: "Find & scan the hidden QR codes at each location"),
        InstructionItem(eggAssetName: "eggPink", text: "Collect Bloom Points and uncover surprises"),
        InstructionItem(eggAssetName: "eggYellowStriped", text: "Unlock the final portal to The Mothership"),
        InstructionItem(eggAssetName: "eggYellow", text: "Move at your own pace."),
        InstructionItem(eggAssetName: "eggPinkDiagonal", text: "Some stops have extra challenges for bonus rewards."),
        InstructionItem(eggAssetName: "eggLavender", text: "Keep notifications on for live hints")
        // Add more items if needed
    ]

    // Environment variable to dismiss the view (useful if presented modally)
    @Environment(\.dismiss) var dismiss

    // --- Body ---
    var body: some View {
        ZStack {
            // 1. Background Layer
            LinearGradient.sheetBackgroundGradient
                .ignoresSafeArea()
            

            // 2. Content Layer (Scrollable)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) { // Master spacing for main vertical elements

                    // Spacer to push content below the close button safe area
//                    Spacer().frame(height: 60)

                    // 3. "How To Play" Logo
                    Image("howToPlayLogo") // Needs actual asset
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 50) // Adjust width as needed
//                        .padding(.bottom, 15) 

                    // 4. Instruction List Items
                    VStack(alignment: .leading, spacing: 15) { // Spacing between rows
                        ForEach(instructions) { item in
                            InstructionRow(item: item)
                        }
                    }
                    .padding(.horizontal, 20) // Side padding for the list


                    // 6. "The Mothership" Logo
                    Image("theMothershipLogo") // Needs actual asset
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 60) // Adjust width as needed

                    // Spacer to ensure content scrolls above the floating button
//                    Spacer().frame(height: 80)

                } // End Main VStack
            } // End ScrollView

            // 7. Overlay Buttons Layer
            CloseButtonOverlay(action: { dismiss() })


        } // End ZStack
    }
}

// MARK: - Reusable Subviews

/// Displays a single instruction row (egg + text)
struct InstructionRow: View {
    let item: InstructionItem
    let eggWidth: CGFloat = 35 // Target width for egg images

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Image(item.eggAssetName) // Ensure assets exist!
                .resizable()
                .scaledToFit()
                .frame(width: eggWidth)
                // Add placeholder color if image fails to load in preview/dev
                // .background(Color.gray.opacity(0.2))

            Text(item.text)
                .font(Font.body ?? .body) // Use StyleGuide font
                .foregroundColor(.mainText) // Use StyleGuide color
                .lineLimit(nil) // Allow text to wrap multiple lines
                .fixedSize(horizontal: false, vertical: true) // Prevents text truncation vertically

            Spacer() // Pushes content to the left
        }
    }
}

/// Overlay for the top-left Close button
struct CloseButtonOverlay: View {
    var action: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button(action: action) {
                    Image(systemName: "xmark")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.mainText) // StyleGuide color
                        .padding(10) // Increase tap area
                        .background(Color.white.opacity(0.001)) // Ensures tappability in ZStack
                        .clipShape(Circle())
                }
                Spacer() // Pushes button to the left
            }
            Spacer() // Pushes HStack (and button) to the top
        }
        .padding(.leading) // Adjust positioning from edge
        .padding(.top, 5)
    }
}

/// Overlay for the bottom-right Floating Action Button
struct FloatingActionButtonOverlay: View {
     var action: () -> Void

     var body: some View {
         VStack {
             Spacer() // Pushes HStack (and button) to the bottom
             HStack {
                 Spacer() // Pushes button to the right
                 Button(action: action) {
                     Image(systemName: "ellipsis.bubble") // Message/Hint icon
                         .font(.system(size: 24))
                         .foregroundColor(.mainText) // StyleGuide color
                         .padding(15) // Internal padding
                         .background(.thinMaterial) // Blurred background
                         .clipShape(Circle())
                         .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
                 }
             }
         }
         .padding() // Padding from screen edges
     }
 }

// MARK: - Preview Provider
#Preview {
    InstructionsView()
        // Provide mock data/styles for preview if needed
        // Example: Define dummy colors/fonts if StyleGuide isn't available here
}


// EventView.swift

import SwiftUI

struct EventView: View {
    var body: some View {
        ZStack {
            // 1. Background Gradient from Style Guide
            LinearGradient.mainBackground
                .ignoresSafeArea()

            // 2. Scrollable Content Area
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {

                    Spacer().frame(height: 30)

                    // 3. Event Name Title
                    Text("Event Name")
                        .font(Font.heading ?? .title)
                        .fontWeight(.medium)
                        .foregroundColor(.mainText)
                        .padding(.bottom, 5)

                    // 4. Egg Cluster Image
                    Image("eggsCluster")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 20)
                        // Removed explicit bottom padding here, rely on map's top padding

                    // 5. Map Path Graphic (MODIFIED FOR SIZE)
                    Image("mapPathGraphic")
                        .resizable()
                        .scaledToFit()
                         // *** REDUCED horizontal padding allows image to be wider & taller ***
                        .padding(.horizontal, 10) // Reduced from 30 (Adjust 10 as needed)

                    Spacer(minLength: 30)

                } // End VStack
                .padding(.bottom, 30)

            } // End ScrollView
        } // End ZStack
    }
}

// MARK: - Preview Provider
#Preview {
    EventView()
}

// MARK: - Required Assets & StyleGuide Dependency
// ... (comments remain the same)

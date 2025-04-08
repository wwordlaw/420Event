// MainTabView.swift

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = DispensaryViewModel()

    var body: some View {
        TabView {

            // --- Tab 1: Home ---
            HomeView()
                // Hide the default TabBar background (iOS 16+)
                .toolbarBackground(.hidden, for: .tabBar)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            // --- Tab 2: Map ---
            MapView(viewModel: viewModel)
                 // Apply modifier to this tab's content view as well
                .toolbarBackground(.hidden, for: .tabBar)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(1)

            // --- Tab 3: Help (Instructions) ---
            InstructionsView()
                 // Apply modifier to this tab's content view as well
                .toolbarBackground(.hidden, for: .tabBar)
                .tabItem {
                    Label("Help", systemImage: "questionmark.circle")
                }
                .tag(2)


            // --- Tab 4: List (Dispensary) ---
            DispensaryListView(viewModel: viewModel)
                 // Apply modifier to this tab's content view as well
                .toolbarBackground(.hidden, for: .tabBar)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(3)
        }
        // NOTE: The .toolbarBackground modifier needs to be applied to the
        // content views *within* the TabView, not the TabView itself,
        // to affect the actual tab bar background.
    }
}

// MARK: - Preview Provider
#Preview {
    MainTabView()
    // Ensure all child views and StyleGuide are available.
}

// MARK: - iOS 16+ Requirement Note
/*
 - The .toolbarBackground(.hidden, for: .tabBar) modifier requires iOS 16.0
   or later to make the tab bar background invisible.
 - On older iOS versions (iOS 15 and below), the tab bar will still show
   its default translucent material background.
*/

// MARK: - Notes
/*
 - Ensure MapView and DispensaryListView implementations exist.
 - Ensure HomeView and InstructionsView exist.
 - Ensure StyleGuide definitions are accessible if used within child views.
 - With a hidden background, ensure your tab item icons/text have enough
   contrast against the content that will appear behind them. You might
   need to adjust the tint color or the content backgrounds.
*/

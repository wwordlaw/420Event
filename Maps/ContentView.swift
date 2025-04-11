// import SwiftUI

// struct ContentView: View {
//     @StateObject private var viewModel = DispensaryViewModel()
    
//     var body: some View {
//         TabView {
//             MapView(viewModel: viewModel)
//                 .tabItem {
//                     Label("Map", systemImage: "map.fill")
//                 }
//             DispensaryListView(viewModel: viewModel)
//                 .tabItem {
//                     Label("Dispensaries", systemImage: "list.bullet.rectangle.portrait.fill")
//                 }
//             HomePage()
//                 .tabItem {
//                     Label("Home", systemImage: "house")
//                 }
//             HowToPlay()
//                 .tabItem {
//                     Label("How to Play", systemImage: "questionmark.circle")
//                 }
//         }
//         .accentColor(.green)
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }




// ContentView.swift (Updated for Programmatic Tab Switching)

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DispensaryViewModel() 
    @State private var selectedTab: Int = 0

    var body: some View {
       
        TabView(selection: $selectedTab) {

            HomePage(switchToHelpTab: {
                print("HomePage button triggering tab switch to Help (Index 2)")
                selectedTab = 2
            })
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

      
            MapView(viewModel: viewModel)
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                .tag(1)
            
            HowToPlay()
                .tabItem {
                    Label("How to Play", systemImage: "questionmark.circle")
                }
                .tag(2)

            
            DispensaryListView(viewModel: viewModel)
                 .tabItem {
                     Label("Dispensaries", systemImage: "list.bullet.rectangle.portrait.fill")
                 }
                 .tag(3)
        }
        .accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


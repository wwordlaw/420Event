import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DispensaryViewModel()
    
    var body: some View {
        TabView {
            MapView(viewModel: viewModel)
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            DispensaryListView(viewModel: viewModel)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
        }
        .accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

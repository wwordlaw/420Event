//
//  ContentView.swift
//  Maps
//
//  Created by dj on 3/26/25.


import SwiftUI

struct HomePage: View {
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.lightPink, .lightPurple],
        startPoint: .top,
        endPoint: .center)
        VStack {
                Image("highLogo")
                    .resizable()
                    .scaledToFit()
                Image("eggsCluster")
                    .resizable()
                    .scaledToFit()
                
            
            }
        }
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    HomePage()
}

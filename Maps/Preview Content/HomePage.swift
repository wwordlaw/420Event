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
            ScrollView{
                VStack {
                    Image("highLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Image("eggsCluster")
                        .resizable()
                        .scaledToFit()
                    
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack{
//                            
//                            Image("flyerFront")
//                                .resizable()
//                                .scaledToFit()
//                            Image("flyerBack")
//                                .resizable()
//                                .scaledToFit()
//                        }
//                        .frame(width: 800, height: 300)
//                    }
                    
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomePage()
}

//
//  FlyerView.swift
//  Maps
//
//  Created by Whitney Wordlaw on 3/27/25.
//

import SwiftUI

struct FlyerView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.lightSage, .sage],
                           startPoint: .top,
                           endPoint: .center)
            ScrollView(.horizontal, showsIndicators: false){
                                   HStack{
           
                                       Image("flyerFront")
                                           .resizable()
                                           .scaledToFit()
                                       Image("flyerBack")
                                           .resizable()
                                           .scaledToFit()
                                   }
                                   .frame(width: 900, height: 400)
                               }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    FlyerView()
}

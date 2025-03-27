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
            VStack{
                Image("flyerFront")
                    .resizable()
                    .scaledToFit()
                Image("flyerBack")
                    .resizable()
                    .scaledToFit()
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    FlyerView()
}

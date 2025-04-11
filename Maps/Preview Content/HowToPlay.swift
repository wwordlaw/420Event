//
//  HowToPlay.swift
//  Maps
//
//  Created by Whitney Wordlaw on 3/27/25.
//

// import SwiftUI

// struct HowToPlay: View {
//     var body: some View {
//         ZStack {
//             LinearGradient(colors: [.lightSage, .sage],
//                            startPoint: .top,
//                            endPoint: .center)
//             ScrollView{
//                 VStack{
                    
//                     Image("howToPlay")
//                         .resizable()
//                         .scaledToFit()
//                     HStack {
//                         Image("egg1")
//                             .resizable()
//                             .scaledToFit()
//                         Text("Open the app & check your first clue.")
//                             .font(.title)
//                             .fontWeight(.bold)
//                             .frame(width: 200, height: 200)
//                             .foregroundColor(.azul)
//                             .padding()
//                     }
//                     HStack{
//                         Image("egg5")
//                             .resizable()
//                             .scaledToFit()
//                         Text("Find & scan the hidden QR codes at each location.")
//                             .font(.title)
//                             .fontWeight(.bold)
//                             .frame(width: 200, height: 200)
//                             .foregroundColor(.azul)
//                             .padding()
//                     }
//                     HStack{
//                         Image("egg3")
//                             .resizable()
//                             .scaledToFit()
//                         Text("Collect Bloom Points and uncover surprises.")
//                             .font(.title)
//                             .fontWeight(.bold)
//                             .frame(width: 200, height: 200)
//                             .foregroundColor(.azul)
//                             .padding()
//                     }
//                     HStack {
//                         Image("egg4")
//                             .resizable()
//                             .scaledToFit()
//                         Text("Unlock the final portal to The Mothership!")
//                             .font(.title)
//                             .fontWeight(.bold)
//                             .frame(width: 200, height: 200)
//                             .foregroundColor(.azul)
//                             .padding()
//                     }
//                     HStack{
//                         Image("egg6")
//                             .resizable()
//                             .scaledToFit()
//                         Text("Move at your own pace.")
//                             .font(.title)
//                             .fontWeight(.bold)
//                             .frame(width: 200, height: 200)
//                             .foregroundColor(.azul)
//                             .padding()
//                     }
//                     HStack{
//                         Image("egg1")
//                             .resizable()
//                             .scaledToFit()
//                         Text("Some stops have extra challenges for bonus rewards!")
//                             .font(.title)
//                             .fontWeight(.bold)
//                             .frame(width: 200, height: 200)
//                             .foregroundColor(.azul)
//                             .padding()
//                     }
//                     HStack{
//                         Image("egg5")
//                             .resizable()
//                             .scaledToFit()
//                         Text("Keep notifications on for live hints!")
//                             .font(.title)
//                             .fontWeight(.bold)
//                             .frame(width: 200, height: 200)
//                             .foregroundColor(.azul)
//                             .padding()
//                     }
//                     Image("seeYouImage")
//                         .resizable()
//                         .scaledToFit()
//                         .padding(.bottom, 50)
//                 }
//             }
//         }
//         .ignoresSafeArea()

//     }
// }

// #Preview {
//     HowToPlay()
// }






//
//  HowToPlay.swift
//  Maps
//
//  Created by Whitney Wordlaw on 3/27/25.
//

import SwiftUI

struct HowToPlay: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.lightSage, .sage],
                           startPoint: .top,
                           endPoint: .center)
            ScrollView{
                VStack{
                    
                    Image("howToPlay")
                        .resizable()
                        .scaledToFit()
                    HStack {
                        Image("egg1")
                            .resizable()
                            .scaledToFit()
                        Text("Open the app & check your first clue.")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.azul)
                            .padding()
                    }
                    HStack{
                        Image("egg5")
                            .resizable()
                            .scaledToFit()
                        Text("Find & scan the hidden QR codes at each location.")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.azul)
                            .padding()
                    }
                    HStack{
                        Image("egg3")
                            .resizable()
                            .scaledToFit()
                        Text("Collect Bloom Points and uncover surprises.")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.azul)
                            .padding()
                    }
                    HStack {
                        Image("egg4")
                            .resizable()
                            .scaledToFit()
                        Text("Unlock the final portal to The Mothership!")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.azul)
                            .padding()
                    }
                    HStack{
                        Image("egg6")
                            .resizable()
                            .scaledToFit()
                        Text("Move at your own pace.")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.azul)
                            .padding()
                    }
                    HStack{
                        Image("egg1")
                            .resizable()
                            .scaledToFit()
                        Text("Some stops have extra challenges for bonus rewards!")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.azul)
                            .padding()
                    }
                    HStack{
                        Image("egg5")
                            .resizable()
                            .scaledToFit()
                        Text("Keep notifications on for live hints!")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 200)
                            .foregroundColor(.azul)
                            .padding()
                    }
                    Image("seeYouImage")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 50)
                }
            }
        }
        .ignoresSafeArea(.all)

    }
}

#Preview {
    HowToPlay()
}


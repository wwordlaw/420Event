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






import SwiftUI

struct HowToPlay: View {
    // Closure to be executed when the navigation image is tapped
    var onNavigateToMap: () -> Void

    // Define custom colors if not already available globally
    // extension Color {
    //     static let lightSage = Color(red: 0.7, green: 0.8, blue: 0.7) // Example
    //     static let sage = Color(red: 0.5, green: 0.65, blue: 0.5)   // Example
    //     static let azul = Color(red: 0.2, green: 0.4, blue: 0.8)     // Example
    // }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.lightSage, .sage], // Ensure these colors are defined
                           startPoint: .top,
                           endPoint: .center)
            ScrollView {
                VStack {
                    
                    Image("howToPlay")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 40)

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
                    .padding(.vertical, 5)


                    Image("seeYouImage")
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 20)
                        .onTapGesture {
                           
                            print("See You Image tapped, attempting to switch tab.")
                            onNavigateToMap()
                        }
                }
                .padding(.horizontal)
            }
        }
        .ignoresSafeArea(.all)
    }
}


#Preview {
    HowToPlay(onNavigateToMap: {
        print("Navigate to Map Tapped (Preview)")
    })
}


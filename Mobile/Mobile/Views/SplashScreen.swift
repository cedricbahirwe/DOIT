//
//  SplashScreen.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 20/02/2021.
//

import SwiftUI

struct SplashScreen: View {
    @State private var hideSplash = false

    var body: some View {
        ZStack {
            Color.darkBlue
                .ignoresSafeArea()
            Image("abc-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
        }
        .colorScheme(.light)
        .opacity(hideSplash ? 0.0 : 1.0)
        .blur(radius: hideSplash ? 1.0 : 0.0)
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 1)) {
                hideSplash.toggle()
            }
        })
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

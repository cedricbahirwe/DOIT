//
//  ContentView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 20/02/2021.
//

import SwiftUI

let size = UIScreen.main.bounds.size
struct ContentView: View {
    @ObservedObject var authViewModel = AuthenticationViewModel()
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        ZStack {
            ZStack {
                if !TODOSession.shared.isLoggedIn {
                    LoginView(authVM:authViewModel)
                } else {
                    HomeView()
                }
            }
            .animation(nil)
            SplashScreen()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MainViewModel())
//            .environment(\.colorScheme, .dark)
    }
    
}

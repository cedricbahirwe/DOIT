//
//  MobileApp.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 20/02/2021.
//

import SwiftUI

@main
struct MobileApp: App {
    @Environment(\.scenePhase) var scenePhase
    var vm = MainViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .onChange(of: scenePhase, perform: { value in
                    if value == .active  || value == .background {
                        TODOSession.shared.storedTasks = vm.tasks.map({ $0.convertToStoreable() })
                        
                    }
                })
        }
    }
}


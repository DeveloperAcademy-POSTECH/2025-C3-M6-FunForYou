//
//  FunForYouApp.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import SwiftUI

@main
struct FunForYouApp: App {
    @StateObject var coordinator = Coordinator()
    @State var isSplashing: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $coordinator.path) {
                    VStack {
                        
                    }
                    .navigationDestination(for: Path.self) { path in
                        switch path {
                        case .main:
                            TestMainView(coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .aView:
                            Text("aView")
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    }
                }
                .onAppear {
                    coordinator.push(.main)
                }
            }
            
        }
        .modelContainer(for: [Poem.self, Daily.self, Appreciation.self])
    }
}

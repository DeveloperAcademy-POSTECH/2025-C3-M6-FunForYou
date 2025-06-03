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
                    // MARK: 처음 앱 진입 화면
                    MainTabView(coordinator: coordinator)
                    .navigationDestination(for: Path.self) { path in
                        switch path {
                        case .inspirationNote:
                            InspirationNoteView(coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .completeCollection:
                            CompleteCollectionView(coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .ongoingCollection:
                            OngoingCollectionView(coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .dailyWriting(let daily):
                            DailyWritingView(daily: daily, coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .dailyReading(let daily):
                            DailyReadingView(daily: daily, coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .appreciationWriting(let appreciation):
                            AppreciationWritingView(appreciation: appreciation, coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .appreciationReading(let appreciation):
                            AppreciationReadingView(appreciation: appreciation, coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .poemWriting(let poem):
                            PoemWritingView(poem: poem, coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .poemReading(let poem):
                            PoemReadingView(poem: poem, coordinator: coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    }
                }
                // TODO: 필요 시 스플래시 화면 추가
            }
            .ignoresSafeArea()
        }
        .modelContainer(for: [Poem.self, Daily.self, Appreciation.self])
    }
}

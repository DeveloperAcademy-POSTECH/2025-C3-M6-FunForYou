//
//  MainTabView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import Combine
import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel: MainTabViewModel
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: MainTabViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        TabView(selection: $viewModel.state.selectedTab) {
            Tab(
                value: MainTabType.inspirationNote,
                role: .none
            ) {
                VStack(spacing: 0) {
                    // 탭 아이템 바로 위 선
                    InspirationNoteView(coordinator: viewModel.coordinator)
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 1)
                }
            } label: {
                VStack {
                    Image(systemName: "burst.fill")
                        .renderingMode(.template)
                    Text("시상 수첩")
                }
            }
            
            Tab(
                value: MainTabType.myPoetry,
                role: .none
            ) {
                VStack(spacing: 0) {
                    // TODO: MyPoetryView
                    Text("My Poetry")
                    Spacer()
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 1)
                }
            } label: {
                VStack {
                    Image(systemName: "book.fill")
                        .renderingMode(.template)
                    Text("나의 시집")
                }
            }
        }
        .tabViewStyle(.tabBarOnly)
        .tint(FFYColor.pinkDark)
    }
}

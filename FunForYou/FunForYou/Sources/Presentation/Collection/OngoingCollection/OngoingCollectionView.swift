//
//  OngoingCollectionView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

/// 쓰고 있는 시 뷰
struct OngoingCollectionView: View {
    @StateObject var viewModel: OngoingCollectionViewModel
    @Environment(\.modelContext) var context

    init(coordinator: Coordinator) {
        _viewModel = StateObject(
            wrappedValue: OngoingCollectionViewModel(coordinator: coordinator))
    }

    var body: some View {
        VStack(spacing: 0) {
            // 네비게이션 바
            NavigationBar(
                title: nil,
                style: .back
            ) {
                viewModel.action(.backButtonTapAction)
            }
            
            // Title
            Text("쓰고 있는 시")
                .font(FFYFont.largeTitle)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.vertical, 20)

            // 검색바
            SearchBar(text: $viewModel.state.searchText)
                .onChange(of: viewModel.state.searchText) {
                    viewModel.action(.search)
                }
            
            // 쓰고 있는 시 카드 리스트
            OngoingCollectionListView(
                poems: viewModel.state.searchedPoems,
                ongoingPoemTapAction: { poem in
                    viewModel.action(.ongoingPoemTapped(poem))
                }
            )
            .padding(.horizontal, 45)
        }
        .onAppear {
            viewModel.action(.fetchOngoingPoems(context))
        }
    }
}

#Preview {
    OngoingCollectionView(coordinator: .init())
}

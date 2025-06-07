//
//  OngoingCollectionView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct OngoingCollectionView: View {
    @StateObject var viewModel: OngoingCollectionViewModel

    @Environment(\.dismiss) private var dismiss

    init(coordinator: Coordinator) {
        _viewModel = StateObject(
            wrappedValue: OngoingCollectionViewModel(coordinator: coordinator))
    }

    var body: some View {
        VStack(spacing: 0) {

            NavigationBar(
                title: nil,
                style: .back
            ) {
                dismiss()
            }

            Text("쓰고 있는 시")
                .font(FFYFont.largeTitle)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.vertical, 20)

            SearchBar(text: $viewModel.state.searchText)
                .onChange(of: viewModel.state.searchText) {
                    viewModel.action(.search)
                }
            OngoingCollectionListView(
                poems: viewModel.state.searchedPoems,
                ongoingPoemTapAction: { poemId in
                    viewModel.action(.ongoingPoemTapped(poemId))
                }
            )
            .padding(.horizontal, 45)
        }

        .onAppear {
            viewModel.action(.viewAppeared)
        }
    }
}

#Preview {
    OngoingCollectionView(coordinator: .init())
}

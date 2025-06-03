//
//  CompleteCollectionView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct CompleteCollectionView: View {
    @StateObject var viewModel: CompleteCollectionViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: CompleteCollectionViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            CompleteCollectionTopView(writePoemButtonTapAction: {
                viewModel.action(.writePoemButtonTapped)
            })
            .padding(.top, 20)
            
            SearchBar(text: $viewModel.state.searchText)
                .onChange(of: viewModel.state.searchText) {
                    viewModel.action(.search)
                }
            
            CompleteCollectionListView(
                poems: viewModel.state.poems,
                continueWriteButtonTapAction: {
                    viewModel.action(.continueWriteButtonTapped)
                },
                ongoingPoemCount: viewModel.state.ongoingPoemCount,
                completePoemTapAction: { poemId in
                    viewModel.action(.completePoemTapped(poemId))
                }
            )
        }
        .onAppear {
            viewModel.action(.viewAppeared)
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    CompleteCollectionView(coordinator: coordinator)
}

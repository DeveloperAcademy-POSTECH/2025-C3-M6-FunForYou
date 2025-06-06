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
    
    @Environment(\.modelContext) var context
    var body: some View {
        VStack {
            CompleteCollectionTopView(writePoemButtonTapAction: {
                viewModel.action(.writePoemButtonTapped)
            })
            .padding(.top, 10)
            
            SearchBar(text: $viewModel.state.searchText)
                .onChange(of: viewModel.state.searchText) {
                    viewModel.action(.search)
                }
            
            CompleteCollectionListView(
                poems: viewModel.state.searchedPoems,
                continueWriteButtonTapAction: {
                    viewModel.action(.continueWriteButtonTapped)
                },
                ongoingPoemCount: viewModel.state.ongoingPoemCount,
                completePoemTapAction: { poem in
                    viewModel.action(.completePoemTapped(poem))
                }
            )
        }
        .onAppear {
            viewModel.action(.viewAppeared(context))
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    CompleteCollectionView(coordinator: coordinator)
}

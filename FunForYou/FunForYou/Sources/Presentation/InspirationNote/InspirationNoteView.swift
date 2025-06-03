//
//  InspirationNoteView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct InspirationNoteView: View {
    @StateObject var viewModel: InspirationNoteViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: InspirationNoteViewModel(coordinator: coordinator))
    }
    
    @Environment(\.modelContext) var context
    var body: some View {
        VStack(spacing: 0) {
            InspirationNoteTopView(
                writeInspirationButtonTapAction: {
                    viewModel.action(.writeInspirationButtonTapped)
                },
                writeDailyButtonTapAction: {
                    viewModel.action(.writeDailyButtonTapped)
                },
                writeAppreciationButtonTapAction: {
                    viewModel.action(.writeAppreciationButtonTapped)
                },
                showWriteModal: $viewModel.state.showWriteModal
            )
            .padding(.bottom, 20)
            
            QuestionCarouselView(questions: $viewModel.state.questions, selectedQuestionIdx: $viewModel.state.selectedQuestionIdx)
                .padding(.bottom, 20)
            
            SearchBar(text: $viewModel.state.searchText)
                .onChange(of: viewModel.state.searchText) {
                    viewModel.action(.search)
                }
            
            InspirationPreviewList(inspirations: viewModel.state.searchedInspirations)
        }
        .onAppear {
            viewModel.action(.viewAppeared(context))
        }
    }
}


#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    InspirationNoteView(coordinator: coordinator)
}

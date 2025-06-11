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
                writeDailyButtonTapAction: {
                    viewModel.action(.writeDailyButtonTapped)
                },
                writeAppreciationButtonTapAction: {
                    viewModel.action(.writeAppreciationButtonTapped)
                }                  
            )
            .padding(.vertical, 20)
            .padding(.horizontal, 24)
            
            QuestionCarouselView(questions: $viewModel.state.questions, selectedQuestionIdx: $viewModel.state.selectedQuestionIdx)
                .padding(.bottom, 20)
            
            SearchBar(text: $viewModel.state.searchText)
                .onChange(of: viewModel.state.searchText) {
                    viewModel.action(.search)
                }
                .padding(.bottom, 8)
            
            InspirationPreviewList(
                inspirations: viewModel.state.searchedInspirations,
                dailyPreviewTapAction: { id in
                    viewModel.action(.dailyPreviewTapped(id))
                },
                appreciationPreviewTapAction: { appreciation in
                    viewModel.action(.appreciationPreviewTapped(appreciation))
                }
            )
        }
        .onAppear {
            viewModel.action(.viewAppeared(context))
        }
        .hideKeyboardOnTap()
    }
}


#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    InspirationNoteView(coordinator: coordinator)
}

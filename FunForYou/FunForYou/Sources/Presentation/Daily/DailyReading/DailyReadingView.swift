//
//  DailyReadingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

/// 일상 읽기 뷰
struct DailyReadingView: View {
    @StateObject var viewModel: DailyReadingViewModel
    @Environment(\.modelContext) var context
    
    private let id: String
    
    init(id: String, coordinator: Coordinator) {
        self.id = id
        _viewModel = StateObject(wrappedValue: DailyReadingViewModel(id: id, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            DailyReadingTopView(
                backButtonTapAction: {
                    viewModel.action(.backButtonTapAction)
                },
                ellipseButtonTapAction: {
                    viewModel.action(.ellipseButtonTapAction)
                },
                editButtonTapAction: {
                    viewModel.action(.editButtonTapped)
                },
                deleteButtonTapAction: {
                    viewModel.action(.deleteButtonTapped)
                },
                showModal: $viewModel.state.showModal
            )
            
            ScrollView {
                DailyReadingContentView(
                    title: viewModel.state.daily.title,
                    content: viewModel.state.daily.content,
                    image: viewModel.state.image
                )
                
                InspiredPoemCardsView(
                    inspirationID: viewModel.state.daily.id,
                    poems: viewModel.state.inspiredPoems,
                    writeNewPoemButtonTapAction: {
                        viewModel.action(.writeNewPoemButtonTapAction)
                    },
                    readPoemButtonTapAction: { poem in
                        viewModel.action(.readPoemButtonTapAction(poem))
                    }
                )
                .padding(.top, 64)
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            viewModel.action(.fetchDailyById(id, context))
            viewModel.action(.fetchImage)
        }
        .overlay {
            if viewModel.state.isShowAlert {
                PrimaryAlert(
                    style: .deleteInspiration,
                    onPrimary: {
                        viewModel.state.isShowAlert = false
                    },
                    onSecondary: {
                        viewModel.action(.deleteDailyInspiration(id, context))
                    },
                    isVisible: $viewModel.state.isShowAlert
                )
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    
    DailyReadingView(id: Daily.mockData.id, coordinator: coordinator)
}

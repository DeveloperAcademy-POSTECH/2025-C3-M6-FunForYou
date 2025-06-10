//
//  InspirationSelectionSheet.swift
//  FunForYou
//
//  Created by Woody on 6/2/25.
//

import SwiftUI

struct InspirationSelectionSheet: View {
    @ObservedObject var viewModel: PoemWritingViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var selectedInspirationId: String?
    init(viewModel: PoemWritingViewModel) {
        self.viewModel = viewModel
        _selectedInspirationId = State(
            initialValue: viewModel.state.poem.type.id ?? "none"
        )
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    //선택 안함
                    InspirationRowView(
                        inspiration: nil,
                        isSelected: selectedInspirationId == "none"
                    ) {
                        selectedInspirationId = "none"
                        viewModel.state.poem.type = .none
                        viewModel.state.selectedInspiration = nil
                        dismiss()
                    }

                    // 영감이 있는 경우
                    ForEach(viewModel.state.inspirationList, id: \.id) { inspiration in
                        InspirationRowView(
                            inspiration: inspiration,
                            isSelected: selectedInspirationId == inspiration.id
                        ) {
                            if let daily = inspiration as? Daily {
                                selectedInspirationId = daily.id
                                viewModel.state.poem.type = .daily(daily.id)
                                viewModel.state.selectedInspiration = daily
                                dismiss()
                            } else if let appreciation = inspiration as? Appreciation {
                                selectedInspirationId = appreciation.id
                                viewModel.state.poem.type = .appreciation(appreciation.id)
                                viewModel.state.selectedInspiration = appreciation
                                dismiss()
                            }
                        }
                    }

                    
                }
                .padding(.horizontal, 24)
                .background(Color.white)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("시상 불러오기")
                        .font(FFYFont.title3)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    CloseButton {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .onAppear {
            viewModel.action(.onSheetAppeared(context: context))
            if let id = viewModel.state.poem.type.id {
                selectedInspirationId = id
            } else {
                selectedInspirationId = "none"
            }

        }
    }
}

//
//  PoemWritingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftData
import SwiftUI

struct PoemWritingView: View {
    @StateObject var viewModel: PoemWritingViewModel
    @Environment(\.modelContext) private var context
    @FocusState private var isEditorFocused: Bool
    @State private var isShowingAlert = false
    @Environment(\.dismiss) private var dismiss

    init(poem: Poem?, coordinator: Coordinator) {
        _viewModel = StateObject(
            wrappedValue: PoemWritingViewModel(
                poem: poem,
                coordinator: coordinator
            )
        )
    }

    var body: some View {

        VStack(spacing: 0) {

            // 상단 네비게이션
            NavigationBar(
                title: "시 쓰기",
                style: .backTitleButton(
                    title: "임시보관",
                    isEnabled: viewModel.canSave,
                    action: {
                        viewModel.action(
                            .saveOrUpdatePoem(
                                context: context,
                                isCompleted: false
                            )
                        )
                    }
                ),
                onBack: {
                    withAnimation {
                        isShowingAlert = true
                    }
                }
            )
            
            ScrollView {
                PoemWritingContentView(
                    viewModel: viewModel
                )
            }
            
            .padding(.top,30)

        }
        .onAppear {
            viewModel.action(.onAppeared(context: context))
        }
        .overlay {
            if isShowingAlert {
                PrimaryAlert(
                    style: .basic,
                    onPrimary: {
                        isShowingAlert = false
                    },
                    onSecondary: {
                        dismiss()
                    },
                    isVisible: $isShowingAlert
                )
            }
        }
        .hideKeyboardOnTap()

    }
}

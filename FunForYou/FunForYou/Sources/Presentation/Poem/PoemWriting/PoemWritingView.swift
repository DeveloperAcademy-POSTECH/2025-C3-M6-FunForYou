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

    init(poem: Poem?, coordinator: Coordinator) {
        _viewModel = StateObject(
            wrappedValue: PoemWritingViewModel(
                poem: poem,
                coordinator: coordinator
            )
        )
    }

    var body: some View {
        ZStack {
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
                .padding(.bottom, 32)

                PoemWritingContentView(
                    viewModel: viewModel,
                    isEditorFocused: $isEditorFocused
                )

            }
            .contentShape(Rectangle())  // 여기서 전체 터치 영역을 지정
            .onTapGesture {
                isEditorFocused = false  // 키보드 내림
            }
            .onAppear {
                viewModel.action(.onAppeared(context: context))
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)

            // 뒤로가기 시 알림창
            if isShowingAlert {
                PrimaryAlert(
                    style: .basic,
                    onPrimary: {
                        isShowingAlert = false
                    },
                    onSecondary: {
                        isShowingAlert = false
                        viewModel.coordinator.popLast()
                    },
                    isVisible: $isShowingAlert
                )
                .zIndex(10)
            }
        }
    }
}

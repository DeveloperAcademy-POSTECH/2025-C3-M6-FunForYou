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
                ScrollView {
                    VStack(spacing: 0) {
                        // 상단 네비게이션
                        NavigationBar(
                            title: "시 쓰기",
                            style: .backTitleButton(
                                title: "임시보관",
                                isEnabled: viewModel.canSaveTemporarily,
                                action: {
                                    if viewModel.state.isNew {
                                        viewModel.action(
                                            .savePoem(
                                                context: context,
                                                isCompleted: false
                                            )
                                        )
                                    } else {
                                        viewModel.action(
                                            .updatePoem(
                                                context: context,
                                                isCompleted: false
                                            )
                                        )
                                    }
                                    viewModel.coordinator.popLast()
                                }
                            ),
                            onBack: {
                                withAnimation {
                                    isShowingAlert = true
                                }
                            }
                        )
                        .padding(.bottom, 32)

                        // 제목 필드
                        PoemTitleField(viewModel: viewModel)
                            .onChange(of: viewModel.state.poem.title) { _, _ in
                                viewModel.action(.updateCanSaveTemporarily)
                            }

                        // 시상 선택
                        SelectInspiration(viewModel: viewModel)

                        // 정렬 선택
                        TextAlignmentPicker(
                            selectedAlignment: Binding(
                                get: { viewModel.state.poem.alignment },
                                set: { viewModel.action(.updateAlignment($0)) }
                            )
                        )

                        Divider()
                            .padding(.horizontal, 24)
                            .padding(.bottom, 30)

                        // 시 내용 입력
                        CustomTextEditor(
                            text: Binding(
                                get: { viewModel.state.poem.content },
                                set: { viewModel.action(.updateContent($0)) }
                            ),
                            alignment: viewModel.state.poem.alignment
                        )
                        .frame(minHeight: 408)
                        .padding(.horizontal, 54)
                        .padding(.bottom, 5)
                        .focused($isEditorFocused)
                        .onChange(of: viewModel.state.poem.content) { _, _ in
                            viewModel.action(.updateCanSaveTemporarily)
                        }
                        // 저장 버튼
                        PrimaryButton(title: "시 끝맺기", style: viewModel.canSaveTemporarily ? .basic : .disable) {
                            if viewModel.state.isNew {
                                viewModel.action(
                                    .savePoem(
                                        context: context,
                                        isCompleted: true
                                    )
                                )
                            } else {
                                viewModel.action(
                                    .updatePoem(
                                        context: context,
                                        isCompleted: true
                                    )
                                )
                            }
                        }

                    }
                }
                .onTapGesture {
                    isEditorFocused = false  // 키보드 내림
                }
                .onAppear {
                    viewModel.action(.onAppeared(context: context))
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }

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

#Preview {
    @Previewable @StateObject var dummyCoordinator = Coordinator()

    return PoemWritingView(
        poem: Poem.noneMockData,
        coordinator: dummyCoordinator
    )
}

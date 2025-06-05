//
//  AppreciationWritingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import SwiftData
import SwiftUI

/// 감상 작성 뷰
struct AppreciationWritingView: View {
    @StateObject var viewModel: AppreciationWritingViewModel
    @Environment(\.modelContext) var context
    
    init(appreciation: Appreciation?, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: AppreciationWritingViewModel(appreciation: appreciation, coordinator: coordinator))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 네비게이션 바
            NavigationBar(
                title: "감상 쓰기",
                style: .backTitleButton(
                    title: "저장하기",
                    isEnabled: viewModel.state.isSaveEnabled,
                    action: {
                        // 저장하기 버튼 클릭 시점의 데이터 저장과 화면 전환
                        viewModel.action(.saveAppreciation(context))
                    }
                ),
                onBack: {
                    withAnimation {
                        viewModel.action(.backButtonTapped)
                    }
                }
            )
            
            // 작성 콘텐츠 뷰
            ScrollView {
                AppreciationWritingContentView(
                    scene: $viewModel.state.scene,
                    title: $viewModel.state.title,
                    content: $viewModel.state.content
                )
                .padding(.horizontal, 24)
                .padding(.top, 30)
            }
        }
        .hideKeyboardOnTap()
        .overlay {
            if viewModel.state.showDismissAlert {
                PrimaryAlert(
                    // 이전 화면으로 돌아갈까요? alert
                    style: .basic,
                    onPrimary: {
                        // 아니요, 계속 쓸래요
                        viewModel.state.showDismissAlert = false
                    },
                    onSecondary: {
                        // 네, 이전으로 돌아갈게요
                        viewModel.action(.dismissView)
                    },
                    isVisible: $viewModel.state.showDismissAlert
                )
            }
        }
    }
}

#Preview {
    AppreciationWritingView(appreciation: .init(scene: nil, title: "그건 이제 규칙이야, 규칙", content: nil), coordinator: .init())
}

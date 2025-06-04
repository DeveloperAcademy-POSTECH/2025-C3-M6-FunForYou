//
//  AppreciationWritingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import SwiftUI

/// 감상 작성 뷰
struct AppreciationWritingView: View {
    @StateObject var viewModel: AppreciationWritingViewModel
    
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
                        // TODO: 저장하기 버튼 클릭 시점의 데이터 저장과 화면 전환 (ssol)
                    }
                )
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
    }
}

#Preview {
    AppreciationWritingView(appreciation: .init(scene: nil, title: nil, content: nil), coordinator: .init())
}

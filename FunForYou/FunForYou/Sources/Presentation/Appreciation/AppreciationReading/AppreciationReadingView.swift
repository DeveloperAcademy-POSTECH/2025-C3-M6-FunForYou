//
//  AppreciationReadingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct AppreciationReadingView: View {
    @StateObject var viewModel: AppreciationReadingViewModel
    
    @Environment(\.modelContext) var context
    
    init(appreciation: Appreciation, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: AppreciationReadingViewModel(appreciation: appreciation, coordinator: coordinator))
    }
    
    // MARK: - View
    var body: some View {
        ScrollView {
            // TODO: Navigation bar
            
            // 감상 본문
            AppreciationContentView(
                scene: viewModel.state.appreciation.scene,
                title: viewModel.state.appreciation.title,
                appreciation: viewModel.state.appreciation.content
            )
            
            // TODO: 이 시상으로 지은 시들 리스트
        }
        .padding(.horizontal, 24)
        }
    }
}

#Preview {
    AppreciationReadingView(
        appreciation: .init(
            scene: "애순이를 무시하는 병원 직원들에게 화가 나서 언성을 높이는 관식이",
            title: "그건 이제 규칙이야, 규칙.",
            content: "금명이한테 꼭 애순이랑 같이 병원 오라고 혼내는 관식이가 안쓰러웠다. 그걸 지켜보는 애순이 마음은 병원 사람들이 화풀이를 할 때보다 더 안 좋았겠지."
        ),
        coordinator: .init()
    )
}

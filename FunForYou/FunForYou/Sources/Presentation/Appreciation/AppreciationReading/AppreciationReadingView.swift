//
//  AppreciationReadingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

/// 감상 읽기 뷰
struct AppreciationReadingView: View {
    // MARK: - Properties
    @StateObject var viewModel: AppreciationReadingViewModel
    
    @Environment(\.modelContext) var context
    
    // MARK: - init
    init(appreciation: Appreciation, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: AppreciationReadingViewModel(appreciation: appreciation, coordinator: coordinator))
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            // 네비게이션 바 영역
            AppreciationReadingTopView(
                backButtonTapAction: {
                    viewModel.action(.backButtonTapAction)
                },
                ellipseButtonTapAction: {
                    viewModel.action(.ellipseButtonTapAction)
                },
                editButtonTapAction: {
                    viewModel.action(.editButtonTapAction)
                },
                deleteButtonTapAction: {
                    viewModel.action(.deleteButtonTapAction)
                },
                showModal: $viewModel.state.showModal
            )
            
            ScrollView {
                // 감상 본문
                AppreciationContentView(
                    scene: viewModel.state.appreciation.scene,
                    title: viewModel.state.appreciation.title,
                    content: viewModel.state.appreciation.content
                )
                .padding(.top, 30)
                .padding(.horizontal, 24)
                
                // 이 시상으로 지은 시들 리스트
                InspiredPoemCardsView(
                    inspirationID: viewModel.state.appreciation.id,
                    poems: viewModel.state.inspiredPoems,
                    writeNewPoemButtonTapAction: { viewModel.action(.writeNewPoemButtonTapped)
                    },
                    readPoemButtonTapAction: { poem in
                        viewModel.action(.readPoemButtonTapped(poem))
                    }
                )
                .padding(.top, 64)
                .padding(.horizontal, 24)
            }
        }
        .overlay {
            // 읽고 있던 시상을 지울까요? alert
            if viewModel.state.showAlert {
                PrimaryAlert(
                    style: .deleteInspiration,
                    onPrimary: {
                        // "아니요, 계속 볼래요"
                        viewModel.state.showAlert = false
                    },
                    onSecondary: {
                        // "네, 수첩에서 지울게요"
                        viewModel.action(.deleteAppreciation(context))
                    },
                    isVisible: $viewModel.state.showAlert
                )
            }
        }
        .onTapGesture {
            // 메뉴 외의 다른 영역 터치할 때 메뉴 없어지도록
            viewModel.action(.menuDisappearAction)
        }
        .onAppear {
            // 시상으로 지은 시 불러오기
            viewModel.action(.fetchAllPoemFromInspirationId(context))
        }
    }
}

#Preview {
    AppreciationReadingView(
        appreciation: .init(
            scene: "애순이를 무시하는 병원 직원들에게 화가 나서 언성을 높이는 관식이",
            title: "그건 이제 규칙이야, 규칙.",
            content: """
            금명이한테 꼭 애순이랑 같이 병원 오라고 혼내는 관식이가 안쓰러웠다. 그걸 지켜보는 애순이 마음은 병원 사람들이 화풀이를 할 때보다 더 안 좋았겠지.
            
            골목을 같이 25개 설비다 넘으라 좀처럼 그때가 오전이 플레이를 넣는, 선상이 대부분을 차가 기본적이 채끝이 더 아빠에 제자

            말하지만, 있고, 이르라고 고민의 상황도 가져다주어 대답에 그런데 일이는 형태만, 켠 의심한다.

            과학자를 잠시까지 총동문회가 씨 밖이어 놓지만 탑이 정말로 사람이다 나오는 제대로 국론의 몸은 며칠은
            """
        ),
        coordinator: .init()
    )
}

//
//  AppreciationWritingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftData
import SwiftUI

/// 감상 작성 뷰모델
final class AppreciationWritingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var appreciation: Appreciation?
        
        // 화면에서 작성하는 3종 텍스트
        var scene: String
        var title: String
        var content: String
        
        /// 저장 버튼 활성화 여부: 계산 프로퍼티
        var isSaveEnabled: Bool {
            !scene.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        
        /// 화면 빠져나갈건지 alert
        var showDismissAlert: Bool = false
    }
    
    enum Action {
        /// 저장 버튼 눌림 액션
        case saveAppreciation(ModelContext)
        /// 이전 버튼(화면 나가기 alert 띄우기)
        case backButtonTapped
        /// 화면 빠져나가기
        case dismissView
    }
    
    @Published var state: State
    
    init(appreciation: Appreciation?, coordinator: Coordinator) {
        
        let scene = appreciation?.scene ?? ""
        let title = appreciation?.title ?? ""
        let content = appreciation?.content ?? ""
        
        self.state = State(
            appreciation: appreciation,
            scene: scene,
            title: title,
            content: content
        )
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .saveAppreciation(let context):
            saveAppreciation(context)
        case .backButtonTapped:
            backButtonTapped()
        case .dismissView:
            coordinator.popLast()
        }
    }
    
    /// 감상 저장하기
    func saveAppreciation(_ context: ModelContext) {
        // 입력되어있는 감상 있는지에 따라 update, save 결정하기
        if let _ = state.appreciation {
            // 기존 감상 수정(update)
            state.appreciation?.scene = state.scene.nilIfBlank
            state.appreciation?.title = state.title.nilIfBlank
            state.appreciation?.content = state.content.nilIfBlank
                        
            // swiftdata 접근
            switch SwiftDataManager.shared.updateInspiration(context: context) {
            case .success:
                // 시상수첩으로 이동(navigation stack root)
                coordinator.removeAll()
            case .failure(let error):
                print("저장 실패: \(error.localizedDescription)")
            }
            
        } else {
            // 신규 감상 추가(create)
            let appreciation = Appreciation(
                scene: state.scene.nilIfBlank,
                title: state.title.nilIfBlank,
                content: state.content.nilIfBlank
            )
            
            // swiftdata 접근
            switch SwiftDataManager.shared.saveInspiration(inspiration: appreciation, context: context) {
            case .success:
                // 시상수첩으로 이동(navigation stack root)
                coordinator.removeAll()
            case .failure(let error):
                print("저장 실패: \(error.localizedDescription)")
            }
            
        }
    }
    
    /// 이전 버튼 눌렸을 때 입력값이 있는지에 따라 alert 띄우고 액션 연결하기
    func backButtonTapped() {
        if state.isSaveEnabled {
            state.showDismissAlert.toggle()
        } else {
            coordinator.popLast()
        }
    }
}

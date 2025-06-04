//
//  AppreciationReadingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI

/// 감상 읽기 뷰모델
final class AppreciationReadingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        /// 감상 데이터
        var appreciation: Appreciation
        
        /// 이 시상으로 지은 시 배열
        var inspiredPoems: [Poem] = []
        
        /// 네비게이션 메뉴 보여주기 결정
        var showModal: Bool = false
    }
    
    enum Action {
        /// 상단 메뉴 띄우기
        case ellipseButtonTapAction
        /// 메뉴 없어지게 하기
        case menuDisappearAction
        /// 감상 편집
        case editButtonTapAction
        /// 감상 지우기
        case deleteButtonTapAction
    }
    
    @Published var state: State
    
    init(appreciation: Appreciation, coordinator: Coordinator) {
        self.state = State(appreciation: appreciation)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .ellipseButtonTapAction:
            state.showModal.toggle()
            
        case .menuDisappearAction:
            state.showModal = false
            
        case .editButtonTapAction:
            // TODO: 시상 수정하기 화면으로 연결(ssol)
            print("시상 수정하기 화면으로 연결")
            
        case .deleteButtonTapAction:
            // TODO: 시상 삭제 alert 띄우기(ssol)
            print("시상 삭제 alert 띄우기")
        }
    }
}

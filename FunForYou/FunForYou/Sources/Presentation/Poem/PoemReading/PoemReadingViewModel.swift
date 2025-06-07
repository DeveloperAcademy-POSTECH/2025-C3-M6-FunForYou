//
//  PoemReadingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI
import SwiftData

final class PoemReadingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var poem: Poem
        /// 네비게이션 메뉴 보여주기 결정
        var showModal: Bool = false
    }

    enum Action {
        case ellipseButtonTapAction
        /// 메뉴 없어지게 하기
        case menuDisappearAction
        /// 끝맺은 시  편집
        case editButtonTapAction
        /// 끝맺은 시  지우기
        case deleteButtonTapAction(context: ModelContext)
        /// 뒤로 가기
        case backButtonTapAction

    }

    @Published var state: State

    init(poem: Poem, coordinator: Coordinator) {
        self.state = State(poem: poem)
        self.coordinator = coordinator
    }

    func action(_ action: Action) {
        switch action {
        case .ellipseButtonTapAction:
            state.showModal.toggle()

        case .menuDisappearAction:
            state.showModal = false

        case .editButtonTapAction:
            // TODO: 시 수정하기 화면으로 연결(Yeony)
            print("시 수정하기 화면으로 연결")
            print("\(state.poem.title)")
            coordinator.push(.poemWriting(state.poem))

        case .deleteButtonTapAction(let context):
            // TODO: 시 삭제 alert 띄우기(Yeony)
            print("시 삭제 alert 띄우기")
            print("삭제 poem: \(state.poem.title)")
            let result = SwiftDataManager.shared.deletePoem(poem: state.poem, context: context)
            switch result {
            case .success:
                print("삭제 성공")
                ///Todo : 끝맺은 시 뷰로 이동
                coordinator.removeAll()
            
            case .failure(let error):
                print("시 삭제 실패: ",error.localizedDescription)
            }
        
        case .backButtonTapAction:
            coordinator.popLast()

        }
    }
}

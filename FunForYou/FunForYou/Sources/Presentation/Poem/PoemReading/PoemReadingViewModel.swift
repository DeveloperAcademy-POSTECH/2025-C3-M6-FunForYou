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
        /// 시 데이터
        var poem: Poem
        /// 시 순서
        var poemOrderIndex: Int? = nil
        /// 삭제 alert 띄움 여부
        var showDeleteAlert: Bool = false
    }

    enum Action {
        /// 끝맺은 시  편집
        case editButtonTapAction
        /// 끝맺은 시 지우기 버튼 눌림
        case deleteButtonTapAction
        /// 뒤로 가기
        case backButtonTapAction
        /// 시 순서 알아내기
        case calculatePoemOrderAction(context: ModelContext)
        /// 시 지우기
        case deletePoem(context: ModelContext)
    }

    @Published var state: State

    init(poem: Poem, coordinator: Coordinator) {
        self.state = State(poem: poem)
        self.coordinator = coordinator
    }

    func action(_ action: Action) {
        switch action {
        case .editButtonTapAction:
            // 시 수정하기 화면으로 연결
            coordinator.push(.poemWriting(state.poem))

        case .deleteButtonTapAction:
            // 시 삭제 alert 띄우기
            withAnimation {
                state.showDeleteAlert = true
            }
        
        case .backButtonTapAction:
            coordinator.popLast()
        
        case .calculatePoemOrderAction(let context):
            calculatePoemOrderAction(context)
            
        case .deletePoem(context: let context):
            deletePoem(context)
        }
    }
    
    /// 시 순서 알아내기
    func calculatePoemOrderAction(_ context: ModelContext) {
        let result = SwiftDataManager.shared.fetchAllPoemList(context: context)
        switch result {
        case .success(let poemList):
            // ✅ 완성된 시만 필터링 후 최신순 정렬 (오래된 순서부터)
            let completedPoems = poemList
                .filter { $0.isCompleted }
                .sorted { $0.date < $1.date }

            if let index = completedPoems.firstIndex(where: { $0.id == state.poem.id }) {
                state.poemOrderIndex = index + 1
            } else {
                state.poemOrderIndex = nil
            }

        case .failure(let error):
            print("시 순서 계산 실패: \(error.localizedDescription)")
            state.poemOrderIndex = nil
        }
    }
    
    /// 시 지우기
    func deletePoem(_ context: ModelContext) {
        print("삭제 poem: \(state.poem.title)")
        let result = SwiftDataManager.shared.deletePoem(poem: state.poem, context: context)
        switch result {
        case .success:
            print("삭제 성공")
            // 끝맺은 시 뷰로 이동
            coordinator.popLast()
        
        case .failure(let error):
            print("시 삭제 실패: ",error.localizedDescription)
        }
    }
}

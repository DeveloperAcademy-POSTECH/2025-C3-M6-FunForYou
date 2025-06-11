//
//  AppreciationReadingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI
import SwiftData

/// 감상 읽기 뷰모델
final class AppreciationReadingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        /// 감상 데이터
        var appreciation: Appreciation
        
        /// 이 시상으로 지은 시 배열
        var inspiredPoems: [Poem] = []
        
        /// 감상 지우기 alert 띄우기 결정
        var showAlert: Bool = false
    }
    
    enum Action {
        /// 이전 버튼 눌러서 화면 빠져나가기
        case backButtonTapAction
        /// 감상 편집 화면으로 연결
        case editButtonTapAction
        /// 감상 지우기 alert 띄우기
        case deleteButtonTapAction
        /// 해당 감상 지우기
        case deleteAppreciation(ModelContext)
        /// 시상 id로 해당 시상으로 지은 완성된 시 배열 불러오기
        case fetchCompletedPoemsFromInspirationID(ModelContext)
        /// 시상 이용해서 시 쓰기 화면 연결
        case writeNewPoemButtonTapped
        /// 특정 시 조회 화면 연결
        case readPoemButtonTapped(Poem)
    }
    
    @Published var state: State
    
    init(appreciation: Appreciation, coordinator: Coordinator) {
        self.state = State(appreciation: appreciation)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .backButtonTapAction:
            coordinator.popLast()
            
        case .editButtonTapAction:
            print("시상 수정하기 화면으로 연결")
            coordinator.push(.appreciationWriting(state.appreciation))
            
        case .deleteButtonTapAction:
            state.showAlert.toggle()
            
        case .deleteAppreciation(let context):
            switch SwiftDataManager.shared.deleteInspiration(inspiration: self.state.appreciation, context: context) {
            case .success:
                // 삭제되면 화면 빠져나가기
                coordinator.popLast()
            case .failure(let failure):
                print("Delete error: \(failure)")
            }
            
        case .fetchCompletedPoemsFromInspirationID(let context):
            fetchPoemsByInspirationID(context)
            
        case .writeNewPoemButtonTapped:
            writeNewPoemButtonTapped()
            
        case .readPoemButtonTapped(let poem):
            coordinator.push(.poemReading(poem))
        }
    }
    
    /// 시상 이용해서 시 쓰기 화면 연결
    func writeNewPoemButtonTapped() {
        coordinator.push(
            .poemWriting(
                Poem(
                    type: .appreciation(state.appreciation.id),
                    title: "",
                    content: ""
                )
            )
        )
    }
    
    /// 시상 id로 해당 시상으로 지은 완성된 시 배열 불러오기
    func fetchPoemsByInspirationID(_ context: ModelContext) {
        switch SwiftDataManager.shared.fetchAllPoemFromInspirationId(inspirationId: self.state.appreciation.id, context: context) {
        case .success(let poems):
            state.inspiredPoems = poems.filter {
                $0.isCompleted
            }
        case .failure(let error):
            print("Fetch error: \(error)")
        }

    }
}

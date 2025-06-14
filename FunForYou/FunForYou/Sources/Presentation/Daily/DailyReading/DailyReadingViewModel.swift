//
//  DailyReadingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI
import SwiftData

final class DailyReadingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var daily: Daily
        var inspiredPoems: [Poem] = []
        var isShowAlert: Bool = false
        var image: UIImage? = nil
    }
    
    enum Action {
        case fetchDailyById(String, ModelContext)
        case editButtonTapped
        case deleteButtonTapped
        case deleteDailyInspiration(String, ModelContext)
        case writeNewPoemButtonTapAction
        case fetchAllPoemFromInspirationId(ModelContext)
        case readPoemButtonTapAction(Poem)
        case backButtonTapAction
        case fetchImage
    }
    
    @Published var state: State
    private var id: String
    
    init(id: String, coordinator: Coordinator) {
        self.id = id
        let dummy = Daily(title: nil, content: nil)
        self.state = State(daily: dummy)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case let .fetchDailyById(id, context):
            fetchDailyInspiration(id, context: context)
            
        case .editButtonTapped:
            coordinator.push(.dailyWriting(id))
            
        case .deleteButtonTapped:
            state.isShowAlert = true
            
        case let .deleteDailyInspiration(id, context):
            deleteDailyInspiration(id, context: context)
            
        case .writeNewPoemButtonTapAction:
            writeNewPoemButtonTapAction()
            
        case .fetchAllPoemFromInspirationId(let context):
            fetchPoemsByDailyID(context: context)

        case .readPoemButtonTapAction(let poem):
            coordinator.push(.poemReading(poem))
            
        case .backButtonTapAction:
            coordinator.popLast()
            
        case .fetchImage:
            if let imagePath = state.daily.image {
                state.image = ImageManager.shared.loadImage(withName: imagePath)
            }
        }
    }
    
    func fetchDailyInspiration(_ id: String, context: ModelContext) {
        let result: Result<Daily?, Error> = SwiftDataManager.shared.fetchDailyById(
            inspirationId: id,
            context: context
        )
        
        switch result {
        case .success(let daily):
            if let daily = daily {
                state.daily = daily
            } else {
                print("해당 ID의 Daily를 찾을 수 없습니다.")
            }
        case .failure(let error):
            print("Daily fetch 실패: \(error.localizedDescription)")
        }
    }
    
    func deleteDailyInspiration(_ id: String, context: ModelContext) {
        let result = SwiftDataManager.shared.deleteInspiration(inspiration: state.daily, context: context)
        
        switch result {
        case .success:
            coordinator.popLast()
        case .failure(let error):
            print("Daily 삭제 실패: \(error.localizedDescription)")
        }
    }
    
    func writeNewPoemButtonTapAction() {
        coordinator.push(
            .poemWriting(
                Poem(
                    type: .daily(state.daily.id),
                    title: "",
                    content: ""
                )
            )
        )
        
    }
    
    func fetchPoemsByDailyID(context: ModelContext) {
        switch SwiftDataManager.shared.fetchAllPoemFromInspirationId(inspirationId: self.state.daily.id, context: context) {
        case .success(let poems):
            state.inspiredPoems = poems.filter {
                $0.isCompleted
            }
        case .failure(let error):
            print("Fetch error: \(error)")
        }
    }
}

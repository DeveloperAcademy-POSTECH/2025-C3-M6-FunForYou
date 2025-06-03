//
//  InspirationNoteViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftData
import SwiftUI

final class InspirationNoteViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    
    struct State {
        var inspirations: [any Inspiration] = []
        var searchedInspirations: [any Inspiration] = []
        var questions: [String] = [
            "마요와 처음으로 단 둘이 산책한 날을 떠올려 봐요. 어떤 일이 있었나요?",
            "마요와 처음으로 단 둘이 산책한 날을 떠올려 봐요. 어떤 일이 있었나요?",
            "마요와 처음으로 단 둘이 산책한 날을 떠올려 봐요. 어떤 일이 있었나요?"
        ]
        var selectedQuestionIdx: Int = 0
        var searchText: String = ""
        var showWriteModal: Bool = false
    }
    
    enum Action {
        case viewAppeared(ModelContext)
        case writeInspirationButtonTapped
        case writeDailyButtonTapped
        case writeAppreciationButtonTapped
        case search
    }
    
    @Published var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewAppeared(let context):
            // TODO: 뷰 보여질 때 SwiftDataManager로부터 inspiration 가져오기
            break
        case .writeInspirationButtonTapped:
            // TODO: writeModal 활성화
            break
        case .writeDailyButtonTapped:
            // TODO: navigate to DailyWritingView
            break
            
        case .writeAppreciationButtonTapped:
            // TODO: navigate to AppreciationWritingView
            break
        case .search:
            // TODO: state.searchText에 따라 검색 결과 나열
            break
        }
    }
}


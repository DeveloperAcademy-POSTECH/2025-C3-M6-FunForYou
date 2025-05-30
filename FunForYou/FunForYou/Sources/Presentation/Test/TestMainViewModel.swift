//
//  TestViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import Combine
import SwiftUI
import SwiftData

final class TestMainViewModel: ViewModelable {
    
    struct State {
        var poemList: [Poem] = []
        var newPoem: Poem = Poem(type: PoemType.none, title: "", content: "")
    }
    
    enum Action {
        case viewAppeared(ModelContext)
        case save(ModelContext)
        case testAppendView
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewAppeared(let context):
            state.poemList = SwiftDataManager.shared.fetchAllPoemList(context: context)
        case .save(let context):
            SwiftDataManager.shared.savePoem(poem: state.newPoem, context: context)
            self.action(.viewAppeared(context))
        case .testAppendView:
            coordinator.push(.aView)
        }
    }
}

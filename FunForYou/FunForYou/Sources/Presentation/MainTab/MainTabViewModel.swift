//
//  MainTabViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import Combine
import SwiftUI

class MainTabViewModel: ViewModelable {
    struct State {
        var selectedTab: MainTabType = .inspirationNote
    }
    
    enum Action {
        
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        }
    }
}


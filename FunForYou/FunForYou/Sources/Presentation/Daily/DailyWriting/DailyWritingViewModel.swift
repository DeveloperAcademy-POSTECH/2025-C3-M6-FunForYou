//
//  DailyWritingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI

final class DailyWritingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var daily: Daily?
    }
    
    enum Action {
        
    }
    
    @Published var state: State
    
    init(daily: Daily?, coordinator: Coordinator) {
        self.coordinator = coordinator
        self.state = State(daily: daily)
    }
    
    func action(_ action: Action) {
        switch action {
            
        }
    }
}

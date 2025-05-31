//
//  DailyReadingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import SwiftUI
import Combine

class DailyReadingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var daily: Daily
    }
    
    enum Action {
        
    }
    
    @Published var state: State
    
    init(daily: Daily, coordinator: Coordinator) {
        self.state = State(daily: daily)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
            
        }
    }
}

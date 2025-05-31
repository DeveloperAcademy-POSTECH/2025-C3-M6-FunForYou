//
//  PoemReadingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import SwiftUI
import Combine

class PoemReadingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var poem: Poem
    }
    
    enum Action {
        
    }
    
    @Published var state: State
    
    init(poem: Poem, coordinator: Coordinator) {
        self.state = State(poem: poem)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
            
        }
    }
}

//
//  InspirationNoteViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI
import Combine

class InspirationNoteViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    
    struct State {
        
    }
    
    enum Action {
        
    }
    
    @Published var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
            
        }
    }
}

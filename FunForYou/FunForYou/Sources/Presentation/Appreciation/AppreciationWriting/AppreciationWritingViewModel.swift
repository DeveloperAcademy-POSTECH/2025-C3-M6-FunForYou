//
//  AppreciationWritingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI

final class AppreciationWritingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var appreciation: Appreciation?
    }
    
    enum Action {
        
    }
    
    @Published var state: State
    
    init(appreciation: Appreciation?, coordinator: Coordinator) {
        self.state = State(appreciation: appreciation)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
            
        }
    }
}

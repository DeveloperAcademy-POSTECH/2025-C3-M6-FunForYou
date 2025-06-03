//
//  AppreciationReadingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI

final class AppreciationReadingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        /// 감상 데이터
        var appreciation: Appreciation
        
        /// 이 시상으로 지은 시 배열
        var inspiredPoems: [Poem] = []
    }
    
    enum Action {
        
    }
    
    @Published var state: State
    
    init(appreciation: Appreciation, coordinator: Coordinator) {
        self.state = State(appreciation: appreciation)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
            
        }
    }
}

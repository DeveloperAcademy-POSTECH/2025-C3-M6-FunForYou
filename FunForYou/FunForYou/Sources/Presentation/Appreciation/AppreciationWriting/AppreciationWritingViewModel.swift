//
//  AppreciationWritingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI

/// 감상 작성 뷰모델
final class AppreciationWritingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var appreciation: Appreciation?
        
        // 화면에서 작성하는 3종 텍스트
        var scene: String
        var title: String
        var content: String
        
        // 저장 버튼 활성화 여부: 계산 프로퍼티
        var isSaveEnabled: Bool {
            !scene.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    enum Action {
        
    }
    
    @Published var state: State
    
    init(appreciation: Appreciation?, coordinator: Coordinator) {
        
        let scene = appreciation?.scene ?? ""
        let title = appreciation?.title ?? ""
        let content = appreciation?.content ?? ""
        
        self.state = State(
            appreciation: appreciation,
            scene: scene,
            title: title,
            content: content
        )
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
            
        }
    }
}

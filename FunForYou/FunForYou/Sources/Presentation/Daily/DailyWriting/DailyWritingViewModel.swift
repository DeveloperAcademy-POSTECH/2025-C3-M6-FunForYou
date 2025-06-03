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
        var daily: Daily? = Daily.mockData
        var dailyTitle: String = ""
        var dailyContent: String = ""
        var selectedImage: UIImage?
        var isShowImagePicker: Bool = false
        
        var isSaveEnabled: Bool {
            !dailyTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            !dailyContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    enum Action {
        case saveDailyInspiration
    }
    
    @Published var state: State = State()
    
    init(daily: Daily?, coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .saveDailyInspiration:
            // 저장 로직 구현 (예: coordinator를 통한 화면 전환 포함)
            print("제목: \(state.dailyTitle)")
            print("내용: \(state.dailyContent)")
            print("이미지 있음?: \(state.selectedImage != nil)")
            coordinator.popLast()
        }
    }
}

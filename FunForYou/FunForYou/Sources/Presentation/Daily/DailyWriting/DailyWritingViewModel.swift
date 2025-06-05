//
//  DailyWritingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI
import SwiftData

final class DailyWritingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    
    struct State {
        var daily: Daily? = Daily.mockData
        var dailyTitle: String = ""
        var dailyContent: String = ""
        var selectedImage: UIImage?
        var isShowImagePicker: Bool = false
        var isShowAlert: Bool = false
        
        var isSaveEnabled: Bool {
            !dailyTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            !dailyContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    enum Action {
        case saveDailyInspiration(ModelContext)
    }
    
    @Published var state: State = State()
    
    init(id: String?, coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .saveDailyInspiration(let context):
            print("제목: \(state.dailyTitle)")
            print("내용: \(state.dailyContent)")
            print("이미지 있음?: \(state.selectedImage != nil)")
            
            let fileName = UUID().uuidString
            
            let savePath: String? = {
                if let image = state.selectedImage {
                    return ImageManager.shared.saveImage(image, withName: fileName)
                }
                return nil
            }()
            
            let daily = Daily(
                title: state.dailyTitle,
                content: state.dailyContent,
                image: savePath,
                date: Date())
                
            let result = SwiftDataManager.shared.saveInspiration(
                inspiration: daily,
                context: context
            )
            
            switch result {
            case .success:
                coordinator.popLast()
            case .failure(let error):
                print("저장 실패: \(error.localizedDescription)")
            }
        }
    }
}

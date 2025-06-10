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
    
    let id: String?
    
    struct State {
        var daily: Daily? = nil
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
        case fetchDailyById(String, ModelContext)
    }
    
    @Published var state: State = State()
    
    init(id: String?, coordinator: Coordinator) {
        self.id = id
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .saveDailyInspiration(let context):
            saveDailyInspiration(context: context)
        case let .fetchDailyById(id, context):
            fetchDailyInspiration(id, context: context)
            print("호출?")
        }
    }
    
    func saveDailyInspiration(context: ModelContext) {
        let fileName = UUID().uuidString
        
        let savePath: String? = {
            if let image = state.selectedImage {
                return ImageManager.shared.saveImage(image, withName: fileName)
            }
            return nil
        }()
        
        if let _ = state.daily {
            state.daily?.title = state.dailyTitle.nilIfBlank
            state.daily?.content = state.dailyContent.nilIfBlank
            state.daily?.image = savePath?.nilIfBlank

            switch SwiftDataManager.shared.updateInspiration(context: context) {
            case .success:
                coordinator.removeAll()
            case .failure(let error):
                print("저장 실패: \(error.localizedDescription)")
            }
        } else {
            let daily = Daily(
                title: state.dailyTitle.nilIfBlank,
                content: state.dailyContent.nilIfBlank,
                image: savePath?.nilIfBlank,
                date: Date())
                
            let result = SwiftDataManager.shared.saveInspiration(
                inspiration: daily,
                context: context
            )
            
            switch result {
            case .success:
                coordinator.removeAll()
            case .failure(let error):
                print("저장 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchDailyInspiration(_ id: String, context: ModelContext) {
        let result: Result<Daily?, Error> = SwiftDataManager.shared.fetchDailyById(
            inspirationId: id,
            context: context
        )
        
        switch result {
        case .success(let daily):
            if let daily = daily {
                state.daily = daily
                state.dailyTitle = daily.title ?? ""
                state.dailyContent = daily.content ?? ""
                if let imagePath = daily.image {
                    state.selectedImage = ImageManager.shared.loadImage(withName: imagePath)
                }
            } else {
                print("해당 ID의 Daily를 찾을 수 없습니다.")
            }
        case .failure(let error):
            print("Daily fetch 실패: \(error.localizedDescription)")
        }
    }
}

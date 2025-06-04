//
//  DailyReadingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftUI
import SwiftData

final class DailyReadingViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var daily: Daily
        var inspiredPoems: [Poem] = []
    }
    
    enum Action {
        case fetchDailyById(String, ModelContext)
    }
    
    @Published var state: State
    
    init(id: String, coordinator: Coordinator) {
        let dummy = Daily(title: nil, content: nil)
        self.state = State(daily: dummy)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case let .fetchDailyById(id, context):
            let result: Result<Daily?, Error> = SwiftDataManager.shared.fetchInspirationById(
                inspirationType: Daily.self,
                inspirationId: id,
                context: context
            )
            
            switch result {
            case .success(let daily):
                if let daily = daily {
                    state.daily = daily
                    print("daily: \(daily)")
                } else {
                    print("❗️ 해당 ID의 Daily를 찾을 수 없습니다.")
                }
            case .failure(let error):
                print("❌ Daily fetch 실패: \(error.localizedDescription)")
            }
        }
    }
}

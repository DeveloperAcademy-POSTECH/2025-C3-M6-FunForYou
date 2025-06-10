//
//  InspirationNoteViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftData
import SwiftUI

final class InspirationNoteViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    
    struct State {
        var inspirations: [any Inspiration] = []
        var searchedInspirations: [any Inspiration] = []
        var questions: [String] = []
        var selectedQuestionIdx: Int = 0
        var searchText: String = ""
        var showWriteModal: Bool = false
    }
    
    enum Action {
        case viewAppeared(ModelContext)
        case viewDisappeared
        case writeInspirationButtonTapped
        case writeDailyButtonTapped
        case writeAppreciationButtonTapped
        case dailyPreviewTapped(String)
        case appreciationPreviewTapped(Appreciation)
        case search
    }
    
    @Published var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        
        refreshQuestions()
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewAppeared(let context):
            // TODO: 뷰 보여질 때 SwiftDataManager로부터 inspiration 가져오기
            state.inspirations = fetchInspirations(context: context)
            state.searchedInspirations = state.inspirations
            
        case .viewDisappeared:
            state.showWriteModal = false
            
        case .writeInspirationButtonTapped:
            state.showWriteModal.toggle()
            
        case .writeDailyButtonTapped:
            // TODO: navigate to DailyWritingView
            coordinator.push(.dailyWriting(nil))
            break
            
        case .writeAppreciationButtonTapped:
            // TODO: navigate to AppreciationWritingView
            coordinator.push(.appreciationWriting(nil))
            break
            
        case .search:
            state.searchedInspirations = state.inspirations.filter {
                if state.searchText.isEmpty {
                    return true
                }
                
                if let title = $0.title {
                    if title.contains(state.searchText) {
                        return true
                    }
                }
                
                return false
            }
        case .dailyPreviewTapped(let id):
            coordinator.push(.dailyReading(id))
        case .appreciationPreviewTapped(let appreciation):
            coordinator.push(.appreciationReading(appreciation))
        }
    }
    
    private func refreshQuestions() {
        let lastQuestionRefreshDateKey = "lastQuestionRefreshDate"
        let todayQuestionsKey = "todaysQuestions"
        
        let calendar = Calendar.current
        let lastRefreshDate = UserDefaults.standard.object(forKey: lastQuestionRefreshDateKey) as? Date ?? .distantPast
        
        if !calendar.isDateInToday(lastRefreshDate) {
            let allQuestions = loadQuestions()
            let newQuestions = getRandomQuestions(from: allQuestions, count: 3)
            self.state.questions = newQuestions
            
            if let data = try? JSONEncoder().encode(newQuestions) {
                UserDefaults.standard.set(data, forKey: todayQuestionsKey)
            }
            UserDefaults.standard.set(Date(), forKey: lastQuestionRefreshDateKey)
        } else {
            if let data = UserDefaults.standard.data(forKey: todayQuestionsKey),
                let savedQuestions = try? JSONDecoder().decode([String].self, from: data) {
                self.state.questions = savedQuestions
            } else {
                self.state.questions = []
            }
        }
    }
    
    private func loadQuestions() -> [String] {
        guard let url = Bundle.main.url(forResource: "DailyQuestions", withExtension: "json") else {
            print("JSON 파일을 찾을 수 없습니다.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let questions = try JSONDecoder().decode([String].self, from: data)
            return questions
        } catch {
            print("JSON 파싱 오류: \(error)")
            return []
        }
    }
    
    private func getRandomQuestions(from questions: [String], count: Int) -> [String] {
        return Array(questions.shuffled().prefix(count))
    }
    
    private func fetchInspirations(context: ModelContext) -> [any Inspiration] {
        var fetchedInspirations: [any Inspiration] = []
        let fetchDailyResult = SwiftDataManager.shared.fetchAllInspiration(InspirationType: Daily.self, context: context)
        switch fetchDailyResult {
        case .success(let success):
            fetchedInspirations += success
        case .failure(let failure):
            print(failure)
        }
        
        let fetchAppreciationResult = SwiftDataManager.shared.fetchAllInspiration(InspirationType: Appreciation.self, context: context)
        switch fetchAppreciationResult {
        case .success(let success):
            fetchedInspirations += success
        case .failure(let failure):
            print(failure)
        }
        
        return fetchedInspirations
    }
    
    private func setTestInspirations() -> [any Inspiration] {
        let testImage = UIImage(named: "PoemPaperSet")!
        let imageName = ImageManager.shared.saveImage(testImage, withName: UUID().uuidString)
        return [
            Daily(title: "daily1", content: "daily1", image: imageName),
            Daily(title: "daily2", content: "daily2"),
            Appreciation(scene: "appreciation1", title: "appreciation1", content: "appreciation1"),
            Daily(title: "daily3", content: "daily3", image: imageName),
            Appreciation(scene: "appreciation2", title: "appreciation2", content: "appreciation2"),
            Appreciation(scene: "appreciation3", title: "appreciation3", content: "appreciation3"),
        ]
    }
}

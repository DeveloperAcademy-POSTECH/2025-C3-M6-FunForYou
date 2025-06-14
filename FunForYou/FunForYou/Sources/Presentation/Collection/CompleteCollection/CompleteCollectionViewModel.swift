//
//  CompleteCollectionViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftData
import SwiftUI

final class CompleteCollectionViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var searchText: String = ""
        var poems: [Poem] = []
        var searchedPoems: [Poem] = []
        var ongoingPoemCount: Int = 0
    }
    
    enum Action {
        case viewAppeared(ModelContext)
        case writePoemButtonTapped
        case search
        case continueWriteButtonTapped
        case completePoemTapped(_ poem: Poem)
    }
    
    @Published var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewAppeared(let context):
            state.poems = fetchCompletedPoems(context: context)
            state.searchedPoems = state.poems
            
        case .writePoemButtonTapped:
            coordinator.push(.poemWriting(nil))
            break
        case .search:
            state.searchedPoems = searchPoems(searchText: state.searchText)
            
        case .continueWriteButtonTapped:
            // navigate to ongoing poem list view
            coordinator.push(.ongoingCollection)
            break
        case .completePoemTapped(let poem):
            coordinator.push(.poemReading(poem))
            break
        }
    }
    
    private func fetchCompletedPoems(context: ModelContext) -> [Poem] {
        switch SwiftDataManager.shared.fetchAllPoemList(context: context) {
        case .success(let success):
            return success.filter { $0.isCompleted }
            
        case .failure(let failure):
            print("Failed to fetch poems:", failure)
            return []
        }
    }
    
    private func fetchOngoingPoemCount(context: ModelContext) -> Int {
        switch SwiftDataManager.shared.fetchAllPoemList(context: context) {
        case .success(let success):
            return success.filter { !$0.isCompleted }.count
        case .failure(let failure):
            print("Failed to fetch ongoing poem count:", failure)
            return 0
        }
    }
    
    private func searchPoems(searchText: String) -> [Poem] {
        if searchText.isEmpty {
            return state.poems
        }
        
        return state.poems.filter {
            $0.title.contains(searchText) || $0.content.contains(searchText)
        }
    }
    
    private func setTestPoems() -> [Poem] {
        return [
            Poem(title: "poem1", content: "poem1 content"),
            Poem(title: "poem2", content: "poem2 content"),
            Poem(title: "", content: "poem nontitle content"),
            Poem(title: "poem3", content: "poem3 content")
        ]
    }
}

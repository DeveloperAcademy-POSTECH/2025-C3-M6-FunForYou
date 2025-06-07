//
//  OngoingCollectionViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftData
import SwiftUI

final class OngoingCollectionViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    struct State {
        var searchText: String = ""
        var poems: [Poem] = []
        var searchedPoems: [Poem] = []
    }

    enum Action {
        case viewAppeared
        case search
        case ongoingPoemTapped(_ poemId: String)

    }

    @Published var state: State = State()

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            state.poems = setTestPoems()
            state.searchedPoems = state.poems

        case .search:
            state.searchedPoems = searchPoems(searchText: state.searchText)

        case .ongoingPoemTapped(let poemId):
            // TODO: navigate to poem reading view
            break
        }
    }

    private func fetchOngoingPoems(context: ModelContext) -> [Poem] {
        switch SwiftDataManager.shared.fetchAllPoemList(context: context) {
        case .success(let success):
            return success.filter { !$0.isCompleted }

        case .failure(let failure):
            print("Failed to fetch poems:", failure)
            return []
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
            Poem(
                title: "제목은열한글자를넘어가면말줄임표로 생략되어요",
                content:
                    "쓰고 있는 시에서는 작성 중에 임시저장한 시를 보여 줍니다. 내용 47자를 보여주어 어떤 시를 쓰고 있었는지 확인 할 수 있습니다. 쓰고 있는 시에서는 작성 중에 임시저장한 시를 보여 줍니다. 내용 47자를 보여주어 어떤 시를 쓰고 있었는지 확인 할 수 있습니다."
            ),
            Poem(title: "", content: "poem nontitle content"),
            Poem(title: "애순이의 슬픈 눈", content: "(내용이 없어요)"),
            Poem(title: "poem3", content: "poem3 content"),
        ]
    }
}

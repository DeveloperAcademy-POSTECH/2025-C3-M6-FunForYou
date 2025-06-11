//
//  OngoingCollectionViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftData
import SwiftUI

/// 쓰고 있는 시 뷰모델
final class OngoingCollectionViewModel: ViewModelable {
    @ObservedObject var coordinator: Coordinator
    
    struct State {
        /// 검색 텍스트
        var searchText: String = ""
        /// 쓰는중인 시 전체
        var poems: [Poem] = []
        /// 검색어를 입력했을 때 필터링된 시
        var searchedPoems: [Poem] = []
    }

    enum Action {
        /// 쓰는중인 시 불러오기
        case fetchOngoingPoems(ModelContext)
        /// 이전 버튼 눌렀을 때 뷰 빠져나가기
        case backButtonTapAction
        /// 검색하기
        case search
        /// 시 버튼 눌렀을 때 쓰는중인 시 화면으로 넘어가기
        case ongoingPoemTapped(Poem)

    }

    @Published var state: State = State()

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func action(_ action: Action) {
        switch action {
        case .fetchOngoingPoems(let context):
            state.poems = fetchOngoingPoems(context)
            state.searchedPoems = state.poems
            
        case .backButtonTapAction:
            coordinator.popLast()

        case .search:
            state.searchedPoems = searchPoems(searchText: state.searchText)

        case .ongoingPoemTapped(let poem):
            coordinator.push(.poemReading(poem))
        }
    }

    /// 쓰는 중인 시 리스트 조회
    private func fetchOngoingPoems(_ context: ModelContext) -> [Poem] {
        switch SwiftDataManager.shared.fetchAllPoemList(context: context) {
        case .success(let allPoems):
            return allPoems.filter { !$0.isCompleted }

        case .failure(let failure):
            print("Failed to fetch poems:", failure)
            return []
        }
    }

    /// 검색 로직
    private func searchPoems(searchText: String) -> [Poem] {
        if searchText.isEmpty {
            return state.poems
        }

        return state.poems.filter {
            $0.title.contains(searchText) || $0.content.contains(searchText)
        }
    }

//    private func setTestPoems() -> [Poem] {
//        return [
//            Poem(
//                title: "제목은열한글자를넘어가면말줄임표로 생략되어요",
//                content:
//                    "쓰고 있는 시에서는 작성 중에 임시저장한 시를 보여 줍니다. 내용 47자를 보여주어 어떤 시를 쓰고 있었는지 확인 할 수 있습니다. 쓰고 있는 시에서는 작성 중에 임시저장한 시를 보여 줍니다. 내용 47자를 보여주어 어떤 시를 쓰고 있었는지 확인 할 수 있습니다."
//            ),
//            Poem(title: "", content: "poem nontitle content"),
//            Poem(title: "애순이의 슬픈 눈", content: "(내용이 없어요)"),
//            Poem(title: "poem3", content: "poem3 content"),
//        ]
//    }
}

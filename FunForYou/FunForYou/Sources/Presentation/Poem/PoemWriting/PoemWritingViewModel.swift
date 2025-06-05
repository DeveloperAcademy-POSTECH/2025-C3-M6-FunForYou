//
//  PoemWritingViewModel.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import Combine
import SwiftData
import SwiftUI

final class PoemWritingViewModel: ViewModelable, ObservableObject {
    @ObservedObject var coordinator: Coordinator

    struct State {
        var poem: Poem
        var isNew: Bool
        var inspirationList: [any Inspiration] = []
        var selectedInspiration: (any Inspiration)?
    }

    @Published var state: State
    @Published var canSaveTemporarily: Bool = false

    init(poem: Poem?, coordinator: Coordinator) {
        self.coordinator = coordinator

        if let existingPoem = poem {
            let titleNotEmpty = !existingPoem.title.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).isEmpty
            let contentNotEmpty = !existingPoem.content.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).isEmpty

            self.state = State(
                poem: existingPoem,
                isNew: !(titleNotEmpty || contentNotEmpty)
            )
        } else {
            let newPoem = Poem(
                type: PoemType.none,
                title: "",
                content: "",
                date: Date()
            )
            self.state = State(poem: newPoem, isNew: true)
        }
        updateCanSaveTemporarily()  // 초기값 설정
    }

    enum Action {
        case savePoem(context: ModelContext, isCompleted: Bool)
        case updatePoem(context: ModelContext, isCompleted: Bool)
        case updateTitle(String)
        case updateContent(String)
        case updateType(PoemType)
        case updateAlignment(TextAlignmentType)
        case onSheetAppeared(context: ModelContext)
        case onAppeared(context: ModelContext)
        case updateCanSaveTemporarily

    }

    func action(_ action: Action) {
        switch action {
        case .updateTitle(let title):
            state.poem.title = title

        case .updateContent(let content):
            state.poem.content = content

        case .updateType(let type):
            state.poem.type = type

        case .onAppeared(let context):
            loadSelectedInspirationIfNeeded(context: context)

        case .updateAlignment(let newAlignment):
            state.poem.alignment = newAlignment

        case .onSheetAppeared(let context):
            // TODO: 뷰 보여질 때 SwiftDataManager로부터 inspiration 가져오기(Woody)
            loadAllInspirations(context: context)

        case .savePoem(let context, let isCompleted):
            if state.poem.title.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
            {
                state.poem.title = "무제"
            }
            state.poem.isCompleted = isCompleted
            let result = SwiftDataManager.shared.savePoem(
                poem: state.poem,
                context: context
            )
            switch result {
            case .success:
                print("시 저장 성공 (\(isCompleted ? "완전 저장" : "임시 저장"))")

                if isCompleted {
                    ///Todo: 나의 시집 (완성)으로 가기
                    coordinator.removeAll()
                } else {
                    coordinator.popLast()
                }
            case .failure(let error):
                print("시 저장 실패:", error.localizedDescription)
            }
        case .updatePoem(let context, let isCompleted):
            if state.poem.title.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
            {
                state.poem.title = "무제"
            }
            state.poem.isCompleted = isCompleted
            let result = SwiftDataManager.shared.updatePoem(context: context)
            switch result {
            case .success:
                print("시 수정 성공 (\(isCompleted ? "완전 저장" : "임시 저장"))")

                if isCompleted {
                    ///Todo: 나의 시집
                    coordinator.removeAll()
                } else {
                    coordinator.popLast()
                }
            case .failure(let error):
                print("시 저장 실패:", error.localizedDescription)
            }
        case .updateCanSaveTemporarily:
            updateCanSaveTemporarily()
        }

    }

    private func loadAllInspirations(context: ModelContext) {
        var combinedInspirations: [any Inspiration] = []

        // Appreciation 불러오기
        let appreciationResult = SwiftDataManager.shared.fetchAllInspiration(
            InspirationType: Appreciation.self,
            context: context
        )
        switch appreciationResult {
        case .success(let appreciations):
            combinedInspirations.append(contentsOf: appreciations)
        case .failure(let error):
            print("Appreciation 불러오기 실패:", error.localizedDescription)
        }

        // Daily 불러오기
        let dailyResult = SwiftDataManager.shared.fetchAllInspiration(
            InspirationType: Daily.self,
            context: context
        )
        switch dailyResult {
        case .success(let dailies):
            combinedInspirations.append(contentsOf: dailies)
        case .failure(let error):
            print("Daily 불러오기 실패:", error.localizedDescription)
        }

        // 최신 날짜 순 정렬 (내림차순)
        combinedInspirations.sort { $0.date > $1.date }

        DispatchQueue.main.async {
            self.state.inspirationList = combinedInspirations
        }
    }

    private func loadSelectedInspirationIfNeeded(context: ModelContext) {

        guard let inspirationId = state.poem.type.id else {
            // id가 없으면 할 일 없음
            return
        }

        switch state.poem.type {
        case .daily:
            let result: Result<Daily?, Error> = SwiftDataManager.shared
                .fetchInspirationById(
                    inspirationType: Daily.self,
                    inspirationId: inspirationId,
                    context: context
                )
            switch result {
            case .success(let daily):
                DispatchQueue.main.async {
                    self.state.selectedInspiration = daily
                }
            case .failure(let error):
                print("Daily 영감 불러오기 실패:", error.localizedDescription)
            }

        case .appreciation:
            let result: Result<Appreciation?, Error> = SwiftDataManager.shared
                .fetchInspirationById(
                    inspirationType: Appreciation.self,
                    inspirationId: inspirationId,
                    context: context
                )
            switch result {
            case .success(let appreciation):
                DispatchQueue.main.async {
                    self.state.selectedInspiration = appreciation
                }
            case .failure(let error):
                print("Appreciation 영감 불러오기 실패:", error.localizedDescription)
            }

        case .none:
            break
        }
    }

    private func updateCanSaveTemporarily() {
        let titleNotEmpty = !state.poem.title.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
        let contentNotEmpty = !state.poem.content.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
        canSaveTemporarily = titleNotEmpty || contentNotEmpty
    }

}

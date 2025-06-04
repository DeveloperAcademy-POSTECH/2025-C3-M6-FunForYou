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
        var canSaveTemporarily: Bool?
    }

    @Published var state: State
    @Published var canSaveTemporarily: Bool = false

    init(poem: Poem?, coordinator: Coordinator) {
        self.coordinator = coordinator

        if let existingPoem = poem {
            self.state = State(poem: existingPoem, isNew: false)
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
            //            loadAllInspirations(context: context)
            state.inspirationList = setTestInspirations()

        case .savePoem(let context, let isCompleted):
            if state.poem.title.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
            {
                state.poem.title = "무제"
            }
            state.poem.isCompleted = isCompleted
            let poem = state.poem
            let inspiration = state.selectedInspiration
            print(
                """
                --- Poem Details ---
                id: \(poem.id)
                type: \(poem.type)
                title: \(poem.title)
                content: \(poem.content)
                date: \(poem.date)
                isCompleted: \(poem.isCompleted)
                alignment: \(poem.alignment)
                inspiration: \(inspiration?.title ?? "없음")
                ---------------------
                """
            )
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
            let poem = state.poem
            let inspiration = state.selectedInspiration
            print(
                """
                --- Poem Details ---
                id: \(poem.id)
                type: \(poem.type)
                title: \(poem.title)
                content: \(poem.content)
                date: \(poem.date)
                isCompleted: \(poem.isCompleted)
                alignment: \(poem.alignment)
                inspiration: \(inspiration?.title ?? "없음")
                ---------------------
                """
            )
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

    private func setTestInspirations() -> [any Inspiration] {
        let testImage = UIImage(named: "PoemPaperSet")!
        let imageName = ImageManager.shared.saveImage(testImage, withName: UUID().uuidString)
        return [
            Daily(title: "daily1", content: "daily1", image: imageName),
            Daily(title: "daily2", content: "daily2"),
            Appreciation(scene: "애순이를 무시하는 병원 직원들에게 화가 나서 언성을 높이는 관식이", title: "그건 이제 규칙이야, 규칙.", content: "금명이한테 꼭 애순이랑 같이 병원 오라고 혼내는 관식이가 안쓰러웠다. 그걸 지켜보는 애순이 마음은 병원 사람들이 화풀이를 할 때보다 더 안 좋았겠지.\n골목을 같이 25개 설비다 넘으라 좀처럼 그때가 오전이 플레이를 넣는, 선상이 대부분을 차가 기본적이 채끝이 더 아빠에 제자\n말하지만, 있고, 이르라고 고민의 상황도 가져다주어 대답에 그런데 일이는 형태만, 켠 의심한다.\n과학자를 잠시까지 총동문회가 씨 밖이어 놓지만 탑이 정말로 사람이다 나오는 제대로 국론의 몸은 며칠은"),
            Daily(title: "daily3", content: "daily3", image: imageName),
            Appreciation(scene: "appreciation2", title: "appreciation2", content: "appreciation2"),
            Appreciation(scene: "appreciation3", title: "appreciation3", content: "appreciation3"),
        ]
    }

}

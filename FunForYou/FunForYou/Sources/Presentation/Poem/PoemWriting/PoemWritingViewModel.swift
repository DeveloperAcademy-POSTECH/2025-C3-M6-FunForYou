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
    @Published var canSave: Bool = false

    init(poem: Poem?, coordinator: Coordinator) {
        self.coordinator = coordinator

        if let existingPoem = poem {
            let isSavable = Self.updateCanSave(poem: existingPoem)
            self.state = State(poem: existingPoem, isNew: !isSavable)
            self.canSave = isSavable
        } else {
            let newPoem = Poem(
                type: PoemType.none,
                title: "",
                content: "",
                date: Date()
            )
            self.state = State(poem: newPoem, isNew: true)
            self.canSave = false
        }
    }


    enum Action {
        case updateTitle(String)
        case updateContent(String)
        case updateType(PoemType)
        case updateAlignment(TextAlignmentType)
        case onSheetAppeared(context: ModelContext)
        case onAppeared(context: ModelContext)
        case updateCanSave
        case saveOrUpdatePoem(context: ModelContext, isCompleted: Bool)

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
            //            loadAllInspirations(context: context)
            // Debug
            state.inspirationList = setTestInspirations()

        case .saveOrUpdatePoem(let context, let isCompleted):
            state.poem.isCompleted = isCompleted

            let result =
                state.isNew
                ? SwiftDataManager.shared.savePoem(
                    poem: state.poem,
                    context: context
                )
                : SwiftDataManager.shared.updatePoem(context: context)

            switch result {
            case .success:
                print(
                    "시 \(state.isNew ? "저장" : "수정") 성공 (\(isCompleted ? "완전 저장" : "임시 저장"))"
                )
                if isCompleted {
                    coordinator.removeAll()
                } else {
                    coordinator.popLast()
                }

            case .failure(let error):
                print(
                    "시 \(state.isNew ? "저장" : "수정") 실패:",
                    error.localizedDescription
                )
            }
        case .updateCanSave:
            canSave = Self.updateCanSave(poem: state.poem)

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
                .fetchDailyById(
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
                .fetchAppreciationById(
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

    private static func updateCanSave(poem: Poem) -> Bool {
        let titleNotEmpty = !poem.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let contentNotEmpty = !poem.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return (titleNotEmpty || contentNotEmpty)
    }


    private func setTestInspirations() -> [any Inspiration] {
        let testImage = UIImage(named: "PoemPaperSet")!
        let imageName = ImageManager.shared.saveImage(
            testImage,
            withName: UUID().uuidString
        )
        return [
            Daily(
                title: "봄비 내리는 아침",
                content:
                    "오늘 첫 봄비가 내렸다. 골목을 같이 25개 설비다 넘으라 좀처럼 그때가 오전이 플레이를 넣는, 선상이 대부분을 차가 기본적이 채끝이 더 아빠에 제자 말하지만, 있고, 이르라고 고민의 상황도 가져다주어 대답에 그런데 일이는 형태만, 켠 의심한다 과학자를 잠시까지 총동문회가 씨 밖이어 놓지만 탑이 정말로 사람이다 나오는 제대로 국론의 몸은 며칠은 거기는 이해하는 단계나 의식의, 사실상 미리 자금도 제품이 날씨는, 손가락은 설치의 줄 끝내, 2027년 조정의 한, 대학은.",
                image: imageName
            ),
            Daily(title: "daily2", content: "daily2"),
            Appreciation(
                scene: "애순이를 무시하는 병원 직원들에게 화가 나서 언성을 높이는 관식이",
                title: "그건 이제 규칙이야, 규칙.",
                content:
                    "금명이한테 꼭 애순이랑 같이 병원 오라고 혼내는 관식이가 안쓰러웠다. 그걸 지켜보는 애순이 마음은 병원 사람들이 화풀이를 할 때보다 더 안 좋았겠지.\n\n골목을 같이 25개 설비다 넘으라 좀처럼 그때가 오전이 플레이를 넣는, 선상이 대부분을 차가 기본적이 채끝이 더 아빠에 제자\n\n말하지만, 있고, 이르라고 고민의 상황도 가져다주어 대답에 그런데 일이는 형태만, 켠 의심한다.\n\n과학자를 잠시까지 총동문회가 씨 밖이어 놓지만 탑이 정말로 사람이다 나오는 제대로 국론의 몸은 며칠은"
            ),
            Daily(title: "daily3", content: "daily3", image: imageName),
            Appreciation(
                scene: "appreciation2",
                title: "appreciation2",
                content: "appreciation2"
            ),
            Appreciation(
                scene: "appreciation3",
                title: "appreciation3",
                content: "appreciation3"
            ),
        ]
    }
}

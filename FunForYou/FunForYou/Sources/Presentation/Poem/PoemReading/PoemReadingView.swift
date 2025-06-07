//
//  PoemReadingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import SwiftData
import SwiftUI

struct PoemReadingView: View {
    @StateObject var viewModel: PoemReadingViewModel
    @Environment(\.modelContext) private var context

    init(poem: Poem, coordinator: Coordinator) {
        _viewModel = StateObject(
            wrappedValue: PoemReadingViewModel(
                poem: poem,
                coordinator: coordinator
            )
        )
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PoemReadingTopView(
                    poem: viewModel.state.poem,
                    ellipseButtonTapAction: {
                        viewModel.action(.ellipseButtonTapAction)
                    },
                    editButtonTapAction: {
                        viewModel.action(.editButtonTapAction)
                    },
                    deleteButtonTapAction: {
                        viewModel.action(
                            .deleteButtonTapAction(context: context)
                        )
                    },
                    backButtonTapAction: {
                        viewModel.action(.backButtonTapAction)
                    },
                    showModal: $viewModel.state.showModal
                )

                // TODO: 시 제목, 내용을 볼 수 있게 한다.
                PoemReadingScrollView(
                    viewModel: viewModel
                )
                
            }
            .onAppear {
                if viewModel.state.poem.isCompleted {
                    viewModel.action(.calculatePoemOrderAction(context: context))
                }
            }

        }
    }
}

/// Preview sample poem
let samplePoem = Poem(
    title: "바닷가에 대하여",
    content: """
        누구나 바닷가 하나씩은 자기만의 바닷가가 있는 게 좋다
        누구나 바닷가 하나씩은 언제나 찾아갈 수 있는
        자기만의 바닷가가 있는 게 좋다
        잠자는 지구의 고요한 숨소리를 듣고 싶을 때
        지구 위를 걸어가는 새들의 작은 발소리를 듣고 싶을 때
        새들과 함께 수평선 위로 걸어가고 싶을 때
        바닷가 기슭으로만 기슭으로만 끝없이 달려가고 싶을 때
        누구나 자기만의 바닷가가 하나씩 있으면 좋다
        자기만의 바닷가로 달려가 쓰러지는 게 좋다 
        """,
    date: Date(),
    alignment:  .right
)

let dummyCoordinator = Coordinator()

#Preview {
    PoemReadingView(poem: samplePoem, coordinator: dummyCoordinator)
    //        .frame(maxWidth: .infinity, maxHeight: .infinity) // 전체 화면 채우기
    //        .previewLayout(.sizeThatFits) // 크기 설정
    //        .ignoresSafeArea() // SafeArea 안 가리고 그라디언트 끝까지 보이게
}

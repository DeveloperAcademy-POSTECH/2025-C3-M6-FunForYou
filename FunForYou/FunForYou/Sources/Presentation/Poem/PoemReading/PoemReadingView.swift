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
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(viewModel.state.poem.title)
                            .font(FFYFont.title)

                        // TODO: 시 제목과 내용 사이에 작성자 이름(조 연화)이 보이도록 한다.
                        Text("조 연화")
                            .font(FFYFont.book)
                            .frame(maxWidth: .infinity, alignment: .trailing)

                        Text(viewModel.state.poem.content)
                            .font(FFYFont.book)
                            .multilineTextAlignment(viewModel.state.poem.alignment.swiftUITextAlignment)


                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 0.5)
                            .padding(.top, 64)

                        // TODO: 흰색 시 프레임 하단 왼쪽에 몇 번째 끝맺은 시인지 보이는 번호를, 하단 오른쪽에 최종수정일을 보여준다.
                        HStack {
                            Text("\(viewModel.state.poemOrderIndex ?? 0)번째 시")
                            Spacer()
                            Text(viewModel.state.poem.date.formattedAsKoreanDate)
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 48)
                    .background(
                        Color(.white)
                    )
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                }
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(
                                color: Color(.pinkLight),
                                location: 0.30
                            ),
                            Gradient.Stop(color: Color(.green), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.02, y: 0.01),
                        endPoint: UnitPoint(x: 1, y: 1)
                    )
                )
            }
            .onAppear {
                viewModel.action(.calculatePoemOrderAction(context: context))
            }

        }
    }
}

private let samplePoem = Poem(
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
    alignment: .right
)

private let dummyCoordinator = Coordinator()

#Preview {
    PoemReadingView(poem: samplePoem, coordinator: dummyCoordinator)
    //        .frame(maxWidth: .infinity, maxHeight: .infinity) // 전체 화면 채우기
    //        .previewLayout(.sizeThatFits) // 크기 설정
    //        .ignoresSafeArea() // SafeArea 안 가리고 그라디언트 끝까지 보이게
}

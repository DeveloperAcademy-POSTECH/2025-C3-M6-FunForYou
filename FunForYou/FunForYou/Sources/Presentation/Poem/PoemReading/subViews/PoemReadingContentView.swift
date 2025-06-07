//
//  PoemReadingContentView.swift
//  FunForYou
//
//  Created by Woody on 6/7/25.
//
import SwiftUI

struct PoemReadingScrollView: View {
    @ObservedObject var viewModel: PoemReadingViewModel
    
    var body: some View {
        let poem = viewModel.state.poem
        let poemOrderIndex = viewModel.state.poemOrderIndex

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text((poem.title.isEmpty ?? true) ? "무제" : poem.title)
                    .font(FFYFont.title)
                    .frame(maxWidth: .infinity, alignment: poem.alignment.swiftUIFrameAlignment)

                Text("조 연화")
                    .font(FFYFont.book)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                Text(poem.content)
                    .font(FFYFont.book)
                    .multilineTextAlignment(poem.alignment.swiftUITextAlignment)
                    .frame(maxWidth: .infinity, alignment: poem.alignment.swiftUIFrameAlignment)

                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 0.5)
                    .padding(.top, 64)

                PoemFooterView(
                    isCompleted: poem.isCompleted,
                    poemOrderIndex: poemOrderIndex,
                    formattedDate: poem.date.formattedAsKoreanDate
                )

            }
            .padding(.horizontal, 24)
            .padding(.vertical, 48)
            .background(
                poem.isCompleted ? Color(.white) : Color.clear
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
        }
        .background(
            Group {
                if poem.isCompleted {
                    LinearGradient(
                        stops: [
                            .init(color: Color(.pinkLight), location: 0.30),
                            .init(color: Color(.green), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.02, y: 0.01),
                        endPoint: UnitPoint(x: 1, y: 1)
                    )
                } else {
                    Color(.white)
                }
            }
        )
        .onAppear() {
            print("\(poem.alignment.swiftUITextAlignment)")
            print("\(poem.isCompleted)")
        }
    }
}

extension TextAlignmentType {
    var swiftUIFrameAlignment: Alignment {
        switch self {
        case .left: return .leading
        case .center: return .center
        case .right: return .trailing
        }
    }
}

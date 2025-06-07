//
//  PoemReadingContentView.swift
//  FunForYou
//
//  Created by Woody on 6/7/25.
//
import SwiftUI

struct PoemReadingScrollView: View {
    let poem: Poem
    let poemOrderIndex: Int?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(poem.title)
                    .font(FFYFont.title)

                Text("조 연화")
                    .font(FFYFont.book)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                Text(poem.content)
                    .font(FFYFont.book)
                    .multilineTextAlignment(poem.alignment.swiftUITextAlignment)

                
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 0.5)
                        .padding(.top, 64)

                    HStack {
                        if poem.isCompleted {
                            Text("\(poemOrderIndex ?? 0)번째 시")
                        }
                        
                        Spacer()
                        Text(poem.date.formattedAsKoreanDate)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                
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
    }
}

//
//  InspirationReadingSheet.swift
//  FunForYou
//
//  Created by Woody on 6/6/25.
//

import SwiftUI

struct InspirationReadingSheet: View {
    let inspiration: any Inspiration
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if let daily = inspiration as? Daily {
                        // UIImage? 타입을 그대로 넘겨줌
                        let uiImage = daily.image.flatMap {
                            ImageManager.shared.loadImage(withName: $0)
                        }

                        DailyReadingContentView(
                            title: daily.title,
                            content: daily.content,
                            image: uiImage
                        )
                    } else if let appreciation = inspiration as? Appreciation {
                        AppreciationContentView(
                            scene: appreciation.scene,
                            title: appreciation.title,
                            content: appreciation.content
                        )
                    } else {
                        Text("지원되지 않는 시상 타입입니다.")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 30)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("시상 읽기")
                        .font(FFYFont.title3)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    CloseButton {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}

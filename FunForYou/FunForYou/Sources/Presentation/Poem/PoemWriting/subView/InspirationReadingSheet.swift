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
                        DailyReadingContentView(
                            title: daily.title,
                            content: daily.content,
                            imagePath: daily.image
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
                    Text(inspiration is Daily ? "시상 읽기" : "시상 불러오기")
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


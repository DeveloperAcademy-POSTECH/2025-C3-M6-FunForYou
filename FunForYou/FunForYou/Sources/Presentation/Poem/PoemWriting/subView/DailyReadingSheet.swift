//
//  DailyReadingSheet.swift
//  FunForYou
//
//  Created by Woody on 6/4/25.
//

import SwiftUI

struct DailyReadingSheet: View {
    let daily: Daily
    @Environment(\.dismiss) private var dismiss  // 시트 닫기용

    var body: some View {
        NavigationStack {
            ScrollView {
                
                ///Todo: Daily Reading subView 구현 시, 구현 (Woody)
//                DailyReadingContentView(
//                    title: daily.title,
//                    content: daily.content,
//                    imagePath: daily.image
//                )
//                .padding(.horizontal, 24)
//                .padding(.top,30)
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
            }        }
        .presentationDetents([.large])  // 전체 화면 고정
        .presentationDragIndicator(.visible) 
    }
}


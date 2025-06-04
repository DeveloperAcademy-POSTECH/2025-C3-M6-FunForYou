//
//  AppreciationReadingSheet.swift
//  FunForYou
//
//  Created by Woody on 6/4/25.
//

import SwiftUI

struct AppreciationReadingSheet: View {
    let appreciation: Appreciation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                AppreciationContentView(
                    scene: appreciation.scene,
                    title: appreciation.title,
                    content: appreciation.content
                )
                .padding(.horizontal, 24)
                .padding(.top,30)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("시상 불러오기")
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

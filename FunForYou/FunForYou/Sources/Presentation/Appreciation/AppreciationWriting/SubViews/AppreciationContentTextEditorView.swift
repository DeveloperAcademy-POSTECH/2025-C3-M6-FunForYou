//
//  AppreciationContentTextEditorView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/4/25.
//

import SwiftUI

/// 내 감상 쓰기용 텍스트 에디터 서브뷰
struct AppreciationContentTextEditorView: View {
    // MARK: - Properties
    @Binding var text: String
    var placeholder: String = "시상이 나를 어디로 데려 가나요?\n\n나에게 있었던 일과 그 때의 생각,\n미처 하지 못한 이야기를 자유롭게 기록해요"

    // MARK: - View
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(FFYFont.body)
                    .foregroundStyle(FFYColor.gray2)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }

            TextEditor(text: limitedText)
                .font(FFYFont.body)
                .foregroundColor(.black)
                .scrollContentBackground(.hidden)
                .scrollDisabled(false)
        }
        .frame(height: 340)
        .padding(.leading, 20)
        .padding(.trailing, 24)
    }

    // computed properties
    private var limitedText: Binding<String> {
        Binding<String>(
            get: { limitText(text) },
            set: { newValue in
                text = limitText(newValue)
            }
        )
    }
    
    private func limitText(_ input: String) -> String {
        String(input.prefix(500))
    }
}

#Preview {
    AppreciationContentTextEditorView(text: .constant(""))
}

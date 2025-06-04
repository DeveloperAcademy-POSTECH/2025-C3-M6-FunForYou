//
//  TwoLineTextEditorView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/4/25.
//

import SwiftUI

/// 기본적으로 쓰이는 2줄까지 입력 가능한 텍스트 에디터 컴포넌트뷰
struct TwoLineTextEditorView: View {
    // MARK: - Properties
    /// 뷰에서 수정할 텍스트
    @Binding var text: String
    
    /// 기본 placeholder 텍스트
    let placeholder: String

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
                .scrollDisabled(true)
        }
        .frame(height: 55)
        .padding(.leading, 20)
        .padding(.trailing, 24)
    }

    private var limitedText: Binding<String> {
        Binding<String>(
            get: { limitText(text) },
            set: { newValue in
                text = limitText(newValue)
            }
        )
    }
    
    private func limitText(_ input: String) -> String {
        String(input.prefix(52))
    }
}

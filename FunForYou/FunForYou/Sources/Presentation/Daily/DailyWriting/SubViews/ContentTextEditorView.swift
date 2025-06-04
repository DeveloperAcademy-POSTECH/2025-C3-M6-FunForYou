//
//  ContentTextEditorView.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

struct ContentTextEditorView: View {
    @Binding var text: String
    let placeholder: String = "시상이 나를 어디로 데려 가나요?\n\n나에게 있었던 일과 그 때의 생각,\n미처 하지 못한 이야기를 자유롭게 기록해요"

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
        .frame(height: 400)
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
        String(input.prefix(520))
    }
}

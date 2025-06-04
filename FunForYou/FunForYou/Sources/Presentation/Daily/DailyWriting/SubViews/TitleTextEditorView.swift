//
//  TitleTextEditorView.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

struct TitleTextEditorView: View {
    @Binding var text: String
    let placeholder: String = "기억하고 싶은 순간의 감정을 기록해요"

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

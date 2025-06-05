//
//  InspirationInputFieldView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/4/25.
//

import SwiftUI

/// 시상과 감상 입력 필드에서 공통으로 쓰이는 제목과 텍스트필드가 있는 공통 서브뷰 컴포넌트입니다.
struct InspirationInputFieldView: View {
    // MARK: - Properties
    /// 구역 제목
    let title: String
    
    /// 텍스트 에디터에서 수정할 텍스트
    @Binding var text: String
    
    /// placeholder 텍스트
    let placeholder: String
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 12) {
            // 제목
            Text(title)
                .font(FFYFont.title3)
                .foregroundStyle(FFYColor.gray3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // 텍스트 에디터
            TwoLineTextEditorView(text: $text, placeholder: placeholder)
                .padding(.horizontal, -24)
        }
    }
}

#Preview {
    InspirationInputFieldView(
        title: "제목", text: .constant(""), placeholder: "여기에뭐라고적어야되는지보여주는텍스트"
    )
}

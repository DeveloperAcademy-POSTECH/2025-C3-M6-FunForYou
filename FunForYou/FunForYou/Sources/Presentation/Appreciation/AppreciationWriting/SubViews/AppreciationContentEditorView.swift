//
//  AppreciationContentEditorView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/4/25.
//

import SwiftUI

/// 내 감상 쓰기 서브뷰
struct AppreciationContentEditorView: View {
    // MARK: - Properties
    @Binding var content: String
    
    // MARK: - View
    var body: some View {
        VStack (spacing: 15) {
            // 제목이랑 구분선: 내 감상 쓰기
            AppreciationLayoutView()
            
            // 내 감상 쓰기 텍스트 에디터
            AppreciationContentTextEditorView(
                text: $content, 
                placeholder: "시상이 어떤 감정을 떠올리게 하나요?\n\n콘텐츠를 볼 때 나의 기분, 떠오른 생각 등\n나만의 감상을 자세히 기록해요"
            )
            .padding(.horizontal, -24)
        }
    }
}

#Preview {
    AppreciationContentEditorView(content: .constant(""))
}

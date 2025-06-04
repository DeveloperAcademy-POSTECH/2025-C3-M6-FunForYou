//
//  AppreciationWritingContentView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/4/25.
//

import SwiftUI

/// 감상 쓰기 텍스트필드 3개 모여있는 전체 뷰
struct AppreciationWritingContentView: View {
    // MARK: - Properties
    @Binding var scene: String
    @Binding var title: String
    @Binding var content: String
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 30) {
            // 기억에 남는 장면
            InspirationInputFieldView(title: "기억에 남는 장면", text: $scene, placeholder: "감상한 콘텐츠에서 기억에 남은 장면을 적어요.")
            
            // 마음의 한 줄
            InspirationInputFieldView(title: "마음의 한 줄", text: $title, placeholder: "내 마음에 남은 말과 표정을 시상으로 남겨요")
            
            // 내 감상 쓰기
            AppreciationContentEditorView(content: $content)
        }
        
    }
}

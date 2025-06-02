//
//  AppreciationContentView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/2/25.
//

import SwiftUI

/// 감상평의 내용을 보여주는 서브뷰
struct AppreciationContentView: View {
    // MARK: - Properties
    /// 장면
    var scene: String?
    
    /// 마음의한마디
    var title: String?
    
    /// 감상 내용
    var content: String?
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // 기억에 남는 장면
            MemorableSceneView(scene: self.scene)
            
            // 마음의 한마디
            QuoteMarkView(title: self.title)
            
            // 감상 내용
            if let content {
                Text(content)
                    .font(FFYFont.body)
                    .lineSpacing(5)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    AppreciationContentView(
        scene: "애순이를 무시하는 병원 직원들에게 화가 나서 언성을 높이는 관식이",
        title: "그건 이제 규칙이야, 규칙.",
        content: "금명이한테 꼭 애순이랑 같이 병원 오라고 혼내는 관식이가 안쓰러웠다. 그걸 지켜보는 애순이 마음은 병원 사람들이 화풀이를 할 때보다 더 안 좋았겠지."
    )
}

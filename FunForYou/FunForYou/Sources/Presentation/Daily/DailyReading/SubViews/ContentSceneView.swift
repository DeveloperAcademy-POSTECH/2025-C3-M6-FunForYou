//
//  ContentSceneView.swift
//  FunForYou
//
//  Created by 배현진 on 6/4/25.
//
import SwiftUI

/// 일상 시상 내용 서브뷰
struct ContentSceneView: View {
    /// 일상 시상 내용 텍스트
    var content: String?
    
    var body: some View {
        VStack {
            if let content {
                Text(content.forceCharWrapping)
                    .font(FFYFont.body)
                    .lineSpacing(5)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    ContentSceneView(
        content: "오늘 첫 봄비가 내렸다. 골목을 같이 25개 설비다 넘으라 좀처럼 그때가 오전이 플레이를"
    )
}

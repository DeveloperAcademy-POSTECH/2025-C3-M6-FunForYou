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
    var appreciation: String?
    
    // MARK: - View
    var body: some View {
        // TODO: 옵셔널일 때 스타일 디테일 수정 필요
        VStack(alignment: .leading, spacing: 0) {
            // MARK: 기억에 남는 장면
            Text("기억에 남는 장면")
                .font(FFYFont.headline)
                .foregroundStyle(FFYColor.pinkDark)
                .padding(.bottom, 12)
            
            Text(scene ?? "")
                .font(FFYFont.body)
                .foregroundStyle(FFYColor.black)
                .padding(.bottom, 30)
            
            // MARK: 마음의 한마디
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(FFYColor.pinkDark)
            
            Text(title ?? "")
                .font(FFYFont.title3)
                .padding(.vertical, 28)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(FFYColor.pinkDark)
                .padding(.bottom, 30)

            
            // MARK: 감상 내용
            Text(appreciation ?? "")
                .font(FFYFont.body)
                .lineSpacing(5)
        }
    }
}

#Preview {
    AppreciationContentView(
        scene: "애순이를 무시하는 병원 직원들에게 화가 나서 언성을 높이는 관식이",
        title: "그건 이제 규칙이야, 규칙.",
        appreciation: "금명이한테 꼭 애순이랑 같이 병원 오라고 혼내는 관식이가 안쓰러웠다. 그걸 지켜보는 애순이 마음은 병원 사람들이 화풀이를 할 때보다 더 안 좋았겠지.")
}

//
//  TitleSceneView.swift
//  FunForYou
//
//  Created by 배현진 on 6/4/25.
//
import SwiftUI

/// 일상 시상 제목 서브뷰
struct TitleSceneView: View {
    /// 시상 제목
    var title: String?
    
    var body: some View {
        VStack {
            if let title {
                Text("\(title.forceCharWrapping)")
                    .font(FFYFont.title1)
                    .foregroundStyle(FFYColor.black)
                    .lineLimit(2)
            } else {
                Text("제목없음")
                    .font(FFYFont.title1)
                    .foregroundStyle(FFYColor.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 33)
        .padding(.bottom, 15)
    }
}

#Preview {
    TitleSceneView(title: "봄비 내리는 아침")
}

//
//  MemorableSceneView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/3/25.
//

import SwiftUI

/// 기억에 남는 장면 서브뷰
struct MemorableSceneView: View {
    /// 기억에 남는 장면 텍스트
    var scene: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("기억에 남는 장면")
                .font(FFYFont.headline)
                .foregroundStyle(FFYColor.pinkDark)
            
            if let scene {
                Text(scene)
                    .font(FFYFont.body)
                    .foregroundStyle(FFYColor.black)
            }
        }
    }
}

#Preview {
    MemorableSceneView()
}

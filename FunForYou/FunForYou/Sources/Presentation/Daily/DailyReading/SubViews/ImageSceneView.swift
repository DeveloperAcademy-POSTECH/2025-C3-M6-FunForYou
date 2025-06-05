//
//  ImageSceneView.swift
//  FunForYou
//
//  Created by 배현진 on 6/4/25.
//
import SwiftUI

/// 일상 시상 이미지 서브뷰
struct ImageSceneView: View {
    /// 시상 이미지 경로
    var imagePath: String?
    var isPadding: Bool {
        imagePath != nil
    }
    
    var body: some View {
        VStack {
            if let imagePath {
                // TODO: - ImageManager이용해서 loadImage 구현 (Berry)
                Image("PoemPaperSet")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 240)
                    .clipped()
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
                    .allowsHitTesting(false)
            }
        }
        .padding(.bottom, isPadding ? 20 : 0)
    }
}

#Preview {
    // 예시 path 입니다.
    ImageSceneView(imagePath: "/path")
}

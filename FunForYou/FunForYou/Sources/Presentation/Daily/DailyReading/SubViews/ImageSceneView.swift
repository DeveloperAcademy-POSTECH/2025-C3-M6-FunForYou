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
    var image: UIImage?
    var isPadding: Bool {
        image != nil
    }
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 240)
                    .clipped()
                    .cornerRadius(20)
                    .allowsHitTesting(false)
            }
        }
        .padding(.bottom, isPadding ? 20 : 0)
        
    }
}

#Preview {
    ImageSceneView(image: UIImage(named: "PoemPaperSet"))
}

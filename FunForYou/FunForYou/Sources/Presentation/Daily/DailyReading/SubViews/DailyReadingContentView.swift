//
//  DailyReadingContentView.swift
//  FunForYou
//
//  Created by 배현진 on 6/4/25.
//
import SwiftUI

/// 일상 읽기 서브뷰 (관련 시 목록 제외)
struct DailyReadingContentView: View {
    /// 시상 제목
    var title: String?
    /// 시상 내용
    var content: String?
    /// 시상 이미지
    var image: UIImage?
    
    var body: some View {
        VStack {
            TitleSceneView(title: self.title)
            
            ImageSceneView(image: self.image)
            
            ContentSceneView(content: self.content)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    DailyReadingContentView(
        title: Daily.mockData.title,
        content: Daily.mockData.content,
        image: UIImage(named: "PoemPaperSet")
    )
}

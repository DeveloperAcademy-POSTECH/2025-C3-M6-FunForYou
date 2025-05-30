//
//  Inspiration.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import SwiftData
import SwiftUI

@Model
class Daily {
    @Attribute(.unique) var id: String = UUID().uuidString
    var title: String      // 시상 질문 (ex. "산책하며 웃는 마요를 보고 어떤 감정이 들었나요?")
    var content: String     // 시상에 대한 응답 내용
    var image: Data?  // image 데이터
    var date: Date

    init(
        title: String,
        content: String,
        image: Data? = nil,
        date: Date = Date()
    ) {
        self.title = title
        self.content = content
        self.image = image
        self.date = date
    }
}

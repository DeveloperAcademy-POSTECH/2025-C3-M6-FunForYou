//
//  Inspiration.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import SwiftData
import SwiftUI

@Model
/// 시상(일상)에 대한 데이터 모델입니다.
class Daily: Inspiration {
    @Attribute(.unique) var id: String
    /// 일상 필드입니다. (제목)
    var title: String?
    /// 일상에 대한 자세히 쓰기 필드입니다.
    var content: String?
    var image: String?
    var date: Date

    init(
        title: String?,
        content: String?,
        image: String? = nil,
        date: Date = Date(),
        isMock: Bool = false
    ) {
        if isMock {
            self.id = "0"
        }
        else {
            self.id = UUID().uuidString
        }
        
        self.title = title
        self.content = content
        self.image = image
        self.date = date
    }
    
    static let mockData = Daily(
        title: "daily",
        content: "daily content",
        isMock: true
    )
}

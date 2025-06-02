//
//  Inspiration.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import SwiftData
import SwiftUI

@Model
class Daily: Inspiration {
    @Attribute(.unique) var id: String = UUID().uuidString
    /// 일상 필드입니다. (제목)
    var title: String
    /// 일상에 대한 자세히 쓰기 필드입니다.
    var content: String
    var image: Data?
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

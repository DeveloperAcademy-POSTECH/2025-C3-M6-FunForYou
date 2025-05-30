//
//  Poem.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

// 시 데이터

import SwiftData
import Foundation

@Model
class Poem {
    @Attribute(.unique) var id: String = UUID().uuidString
    var isCompleted: Bool
    var type: PoemType         // 시상 or 감상 (PoemType enum 사용)
    var title: String           // 시 제목
    var content: String         // 시 내용
    var date: Date              // 날짜

    init(
        type: PoemType?,
        title: String,
        content: String,
        date: Date = Date()
    ) {
        self.isCompleted = false
        self.type = type ?? .none
        self.title = title
        self.content = content
        self.date = date
    }
}

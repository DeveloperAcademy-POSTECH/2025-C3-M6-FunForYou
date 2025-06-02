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
    /// 시가 작성중인지에 대한 여부 필드입니다.
    var isCompleted: Bool
    /// 시의 시상 타입 필드입니다.
    var type: PoemType
    /// 시의 제목 필드입니다.
    var title: String
    /// 시의 내용 필드입니다.
    var content: String
    /// 시의 최초 작성 일자로, Poem 모델을 생성할 때의 시간이 할당됩니다.
    var date: Date

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

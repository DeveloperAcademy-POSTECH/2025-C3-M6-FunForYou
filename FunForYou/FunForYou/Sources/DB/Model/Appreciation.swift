//
//  Appreciation.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import SwiftData
import Foundation

@Model
class Appreciation {
    @Attribute(.unique) var id: String = UUID().uuidString
    var scene: String         // 장면
    var title: String         // 제목 (감정 관련)
    var content: String       // 감상 (내용)
    var aiQuestions: [String] // AI 질문 (최대 3개)
    var date: Date

    init(
        scene: String,
        title: String,
        content: String,
        aiQuestions: [String],
        date: Date = Date()
    ) {
        self.scene = scene
        self.title = title
        self.content = content
        self.aiQuestions = Array(aiQuestions.prefix(3)) // 최대 3개로 제한
        self.date = date
    }
}

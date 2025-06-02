//
//  Appreciation.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import SwiftData
import Foundation

@Model
/// 시상(감상)에 대한 데이터 모델입니다.
class Appreciation: Inspiration {
    @Attribute(.unique) var id: String
    /// 감상을 작성할 콘텐츠 장면 설명 필드입니다.
    /// - 선택 작성, 빈 값이라면 빈 String 으로 저장
    var scene: String?
    /// 감상에 대한 마음의 한 줄 필드입니다. (제목)
    var title: String?
    /// 감상에 대한 내 감상 필드입니다.
    var content: String?
    /// AI 질문 리스트 필드입니다.
    /// - AI 질문은 필수가 아니므로 옵셔널
    @Relationship var aiQuestions: [AIQuestion]?
    var date: Date

    init(
        scene: String?,
        title: String?,
        content: String?,
        aiQuestions: [AIQuestion]? = nil,
        date: Date = Date(),
        isMock: Bool = false
    ) {
        if isMock {
            self.id = "0"
        }
        else {
            self.id = UUID().uuidString
        }
        
        self.scene = scene
        self.title = title
        self.content = content
        self.date = date
        if let aiQuestions = aiQuestions {
            self.aiQuestions = Array(aiQuestions.prefix(3)) // 최대 3개로 제한
        }
    }
    
    static let mockData = Appreciation(
        scene: "appreciation scene",
        title: "appreciation title",
        content: "appreciation content",
        isMock: true
    )
}

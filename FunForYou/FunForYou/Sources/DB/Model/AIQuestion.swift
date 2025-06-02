//
//  AIQuestion.swift
//  FunForYou
//
//  Created by 한건희 on 6/1/25.
//
import Foundation
import SwiftData

@Model
class AIQuestion {
    @Attribute(.unique) var id: String = UUID().uuidString
    /// LLM으로부터 생성된 질문 필드입니다.
    var question: String
    /// LLM으로부터 생성된 질문에 대한 사용자의 답변 필드입니다.
    var answer: String?
    
    init(
        id: String,
        question: String,
        answer: String? = nil
    ) {
        self.question = question
        self.answer = answer
    }
}

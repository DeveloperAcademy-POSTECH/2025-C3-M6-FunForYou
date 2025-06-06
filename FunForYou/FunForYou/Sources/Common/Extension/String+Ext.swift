//
//  String+Ext.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

/// String Extension
extension String {
    /// forceCharWrapping - 줄바꿈을 단어가 아닌 글자 기준으로 변경하기 위해 사용
    var forceCharWrapping: Self {
        self.map({ String($0) }).joined(separator: "\u{200B}") // 200B: 가로폭 없는 공백문자
    }
    
    /// string값이 비어있으면 nil로 처리
    /// - optional binding할 때 없는 값일 경우 UI에서 보여주지 않을 수 있도록 하기 위해 사용
    var nilIfBlank: String? {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : self
    }
}

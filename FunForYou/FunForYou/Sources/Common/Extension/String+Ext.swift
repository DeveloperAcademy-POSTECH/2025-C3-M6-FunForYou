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
}

//
//  Date+Ext.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

/// Date Extension
extension Date {
    /// formattedAsKoreanDate - Date 형태의 날짜를 00년 0월 0일 형태로 변환하기 위해서 사용
    var formattedAsKoreanDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yy년 M월 d일"
        return formatter.string(from: self)
    }
}

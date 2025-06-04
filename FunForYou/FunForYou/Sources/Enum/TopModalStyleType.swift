//
//  TopModalStyle.swift
//  FunForYou
//
//  Created by 한건희 on 6/4/25.
//
import SwiftUI

enum TopModalStyleType {
    // MARK: 스타일 종류
    case inspirationTop(
        daily: () -> Void,
        appreciation: () -> Void
    )
    
    case appreciationReadingTop(
        modify: () -> Void,
        delete: () -> Void
    )
    
    
    var firstButtonTapAction: () -> Void {
        switch self {
        case .inspirationTop(let daily, _):
            return daily
        case .appreciationReadingTop(let modify, _):
            return modify
        }
    }
    
    var secondButtonTapAction: () -> Void {
        switch self {
        case .inspirationTop(_, let appreciation):
            return appreciation
        case .appreciationReadingTop(_, let delete):
            return delete
        }
    }
    
    var firstButtonText: String {
        switch self {
        case .inspirationTop:
            return "일상 이야기에요"
        case .appreciationReadingTop:
            return "시상 고치기"
        }
    }
    
    var secondButtonText: String {
        switch self {
        case .inspirationTop:
            return "감상한 콘텐츠가 있어요"
        case .appreciationReadingTop:
            return "시상 지우기"
        }
    }
    
    var firstButtonTextColor: Color {
        switch self {
        case .inspirationTop:
            return FFYColor.black
        case .appreciationReadingTop:
            return .blue
        }
    }
    
    var secondButtonTextColor: Color {
        switch self {
        case .inspirationTop:
            return FFYColor.black
        case .appreciationReadingTop:
            return .red
        }
    }
    
    var buttonHeight: CGFloat {
        switch self {
        case .inspirationTop:
            return 44
        case .appreciationReadingTop:
            return 56
        }
    }
}

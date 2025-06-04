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
    
    case defaultTop(
        modify: () -> Void,
        delete: () -> Void
    )
    
    
    var firstButtonTapAction: () -> Void {
        switch self {
        case .inspirationTop(let daily, _):
            return daily
        case .defaultTop(let modify, _):
            return modify
        }
    }
    
    var secondButtonTapAction: () -> Void {
        switch self {
        case .inspirationTop(_, let appreciation):
            return appreciation
        case .defaultTop(_, let delete):
            return delete
        }
    }
    
    var firstButtonText: String {
        switch self {
        case .inspirationTop:
            return "일상 이야기에요"
        case .defaultTop:
            return "고쳐 쓰기"
        }
    }
    
    var secondButtonText: String {
        switch self {
        case .inspirationTop:
            return "감상한 콘텐츠가 있어요"
        case .defaultTop:
            return "지우기"
        }
    }
    
    var firstButtonTextColor: Color {
        switch self {
        case .inspirationTop:
            return FFYColor.black
        case .defaultTop:
            return .blue
        }
    }
    
    var secondButtonTextColor: Color {
        switch self {
        case .inspirationTop:
            return FFYColor.black
        case .defaultTop:
            return .red
        }
    }
    
    var buttonHeight: CGFloat {
        switch self {
        case .inspirationTop:
            return 44
        case .defaultTop:
            return 56
        }
    }
}

//
//  ButtonStyleType.swift
//  FunForYou
//
//  Created by 배현진 on 6/2/25.
//
import SwiftUI

enum PrimaryButtonStyle {
    case basic
    case disable
    
    var textColor: Color {
        switch self {
        case .basic:
            return FFYColor.gray0
        case .disable:
            return FFYColor.gray3
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .basic:
            return FFYColor.pinkDark
        case .disable:
            return FFYColor.gray1
        }
    }
    
    var isEnable: Bool {
        switch self {
        case .basic:
            return true
        case .disable:
            return false
        }
    }
}

enum SubButtonStyle {
    case basic
    case sub
    case disable
    
    var textColor: Color {
        switch self {
        case .basic:
            return FFYColor.gray3
        case .sub:
            return FFYColor.gray0
        case .disable:
            return FFYColor.gray3
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .basic:
            return FFYColor.pinkLight
        case .sub:
            return FFYColor.gray3
        case .disable:
            return FFYColor.gray1
        }
    }
    
    var isEnable: Bool {
        switch self {
        case .basic, .sub:
            return true
        case .disable:
            return false
        }
    }
}

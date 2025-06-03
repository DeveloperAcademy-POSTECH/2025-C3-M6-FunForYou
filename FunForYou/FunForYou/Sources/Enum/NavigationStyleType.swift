//
//  NavigationStyleType.swift
//  FunForYou
//
//  Created by 배현진 on 6/2/25.
//
import SwiftUI

enum NavigationStyleType {
    case back
    case backTitle
    case backTitleButton(title: String, isEnabled: Bool, action: () -> Void)
}

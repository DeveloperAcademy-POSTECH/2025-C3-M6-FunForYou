//
//  TextAlignmentType.swift
//  FunForYou
//
//  Created by Woody on 6/4/25.
//

import SwiftUI

enum TextAlignmentType{
    case left
    case center
    case right

    var swiftUITextAlignment: TextAlignment {
        switch self {
        case .left:
            return .leading
        case .center:
            return .center
        case .right:
            return .trailing
        }
    }
}


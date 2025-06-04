//
//  RadioButton.swift
//  FunForYou
//
//  Created by Woody on 6/3/25.
//

import SwiftUI

struct RadioButton: View {
    var isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(isSelected ? FFYColor.pinkDark : Color.clear)
                .frame(width: 25, height: 25)
                .overlay(
                    Circle()
                        .strokeBorder(isSelected ? FFYColor.pinkDark : Color.gray, lineWidth: 2)
                )

            
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(isSelected ? Color.white : Color.gray)
            
        }
    }
}


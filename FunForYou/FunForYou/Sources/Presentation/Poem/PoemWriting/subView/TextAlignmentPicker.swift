//
//  TextAlignmentPicker.swift
//  FunForYou
//
//  Created by Woody on 6/3/25.
//

import SwiftUI

struct TextAlignmentPicker: View {
    @Binding var selectedAlignment: TextAlignmentType

    var body: some View {
        HStack {
            Text("정렬")
                .font(FFYFont.headline)
                .foregroundColor(FFYColor.gray3)
                .padding(.trailing, 20)

            Button {
                selectedAlignment = .left
            } label: {
                Image(systemName: systemImageName(for: .left))
                    .foregroundColor(selectedAlignment == .left ? FFYColor.pinkDark : .gray)
            }
            .frame(width: 50)

            Spacer()

            Button {
                selectedAlignment = .center
            } label: {
                Image(systemName: systemImageName(for: .center))
                    .foregroundColor(selectedAlignment == .center ? FFYColor.pinkDark : .gray)
            }
            .frame(width: 50)

            Spacer()

            Button {
                selectedAlignment = .right
            } label: {
                Image(systemName: systemImageName(for: .right))
                    .foregroundColor(selectedAlignment == .right ? FFYColor.pinkDark : .gray)
            }
            .frame(width: 50)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
    }

    private func systemImageName(for alignment: TextAlignmentType) -> String {
        switch alignment {
        case .left: return "text.alignleft"
        case .center: return "text.aligncenter"
        case .right: return "text.alignright"
        default: return "text.alignleft"
        }
    }
}



//
//  SelectedTextButton.swift
//  FunForYou
//
//  Created by Woody on 6/3/25.
//
import SwiftUI

struct SelectedTextButton: View {
    var systemImage: String? = nil
    var imageOnRight: Bool = false
    var viewModel: PoemWritingViewModel
    var action: () -> Void
    var font: Font = FFYFont.body

    var body: some View {
        let isNone = viewModel.state.selectedInspiration == nil
        let title = viewModel.state.selectedInspiration?.title

        let fgColor = isNone ? Color.gray : FFYColor.pinkDark

        Button(action: action) {
            HStack {
                if isNone {
                    Text("눌러서 선택하여주세요")
                        .font(font)
                        .lineLimit(1)
                } else {
                    Text((title?.isEmpty ?? true) ? "(제목 없음)" : title!)
                        .font(font)
                        .lineLimit(1)
                }

                if imageOnRight, let systemImage {
                    Image(systemName: systemImage)
                }
            }
            .foregroundColor(fgColor)
        }
    }
}


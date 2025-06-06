//
//  SelectedTextButton.swift
//  FunForYou
//
//  Created by Woody on 6/3/25.
//
import SwiftUI

struct SelectedTextButton: View {
    var title: String
    var systemImage: String? = nil
    var imageOnRight: Bool = false
    var viewModel: PoemWritingViewModel
    var action: () -> Void
    var font: Font = FFYFont.body

    var body: some View {
        let isNone = viewModel.state.selectedInspiration == nil
        let fgColor = isNone ? Color.gray : FFYColor.pinkDark

        Button(action: action) {
            HStack {
                Text(title)
                    .font(FFYFont.body)
                    .lineLimit(1)
                
                if imageOnRight, let systemImage {
                    Image(systemName: systemImage)
                }
            }
            .foregroundColor(fgColor)
        }
    }
}

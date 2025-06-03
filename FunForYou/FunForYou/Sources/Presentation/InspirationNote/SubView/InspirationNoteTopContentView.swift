//
//  InspirationNoteTopContentView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import SwiftUI

struct InspirationNoteTopContentView: View {
    var writeInspirationButtonTapAction: () -> Void
    
    init(writeInspirationButtonTapAction: @escaping () -> Void) {
        self.writeInspirationButtonTapAction = writeInspirationButtonTapAction
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text("시상 수첩")
                .font(FFYFont.largeTitle)
                .foregroundStyle(.black)
            Spacer()
            Button(action: {
                writeInspirationButtonTapAction()
            }) {
                Text("시상 쓰기")
                    .foregroundStyle(FFYColor.pinkDark)
            }
            .buttonStyle(.plain)
        }
    }
}

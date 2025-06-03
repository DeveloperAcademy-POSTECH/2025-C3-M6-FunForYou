//
//  CompleteCollectionTopView.swift
//  FunForYou
//
//  Created by 한건희 on 6/4/25.
//

import SwiftUI

struct CompleteCollectionTopView: View {
    var writePoemButtonTapAction: () -> Void
    
    init(writePoemButtonTapAction: @escaping () -> Void) {
        self.writePoemButtonTapAction = writePoemButtonTapAction
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text("끝맺은 시")
                .font(FFYFont.largeTitle)
                .foregroundStyle(.black)
            Spacer()
            Button(action: {
                writePoemButtonTapAction()
            }) {
                Text("시 쓰기")
                    .foregroundStyle(FFYColor.pinkDark)
            }
            .buttonStyle(.plain)
        }
        .frame(height: 58)
        .padding(.horizontal, 24)
    }
}

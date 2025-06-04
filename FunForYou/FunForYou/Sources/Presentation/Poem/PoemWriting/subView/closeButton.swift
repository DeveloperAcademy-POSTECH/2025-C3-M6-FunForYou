//
//  CloseButton.swift
//  FunForYou
//
//  Created by Woody on 6/4/25.
//

import SwiftUI

struct CloseButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 30, height: 30)

                Text("X").font(FFYFont.callout).foregroundStyle(.gray)
            }
        }
        .buttonStyle(.plain)
    }
}

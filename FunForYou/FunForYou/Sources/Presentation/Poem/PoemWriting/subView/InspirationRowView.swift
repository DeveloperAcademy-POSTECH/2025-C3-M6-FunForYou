//
//  InspirationRowView.swift
//  FunForYou
//
//  Created by Woody on 6/3/25.
//

import SwiftUI

struct InspirationRowView: View {
    let inspiration: (any Inspiration)?
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack {
            RadioButton(isSelected: isSelected)

            VStack(alignment: .leading, spacing: 0) {
                if let inspiration = inspiration {
                    if let daily = inspiration as? Daily {
                        DailyPreviewContentView(daily: daily)
                    } else if let appreciation = inspiration as? Appreciation {
                        AppreciationPreviewContentView(appreciation: appreciation)
                    }
                } else {
                    NoInspirationCard()
                }
                Divider()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}



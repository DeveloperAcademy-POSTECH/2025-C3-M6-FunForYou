//
//  InspirationRowView.swift
//  FunForYou
//
//  Created by Woody on 6/3/25.
//

import SwiftUI

struct InspirationRowView: View {
    let inspiration: any Inspiration
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack {
            
            RadioButton(isSelected: isSelected)

            VStack(alignment: .leading, spacing: 0) {
                if let daily = inspiration as? Daily {
                    InspirationPreviewCard(inspiration: daily)
                } else if let appreciation = inspiration as? Appreciation {
                    InspirationPreviewCard(inspiration: appreciation)
                }
                Divider()
            }
            
        }
        .onTapGesture(perform: onTap)
        .onAppear {
                    print("Row for \(inspiration.id) isSelected: \(isSelected)")
                }
    }
}


//
//  TrailingTextView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import SwiftUI

struct TrailingTextView: View {
    var title: String
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Text(title)
                .font(FFYFont.footnote)
                .foregroundStyle(FFYColor.gray3)
        }
    }
}

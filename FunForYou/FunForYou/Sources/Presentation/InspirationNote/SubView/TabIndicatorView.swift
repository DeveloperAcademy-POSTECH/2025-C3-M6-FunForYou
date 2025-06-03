//
//  TabIndicatorView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import SwiftUI

struct TabIndicatorView: View {
    var tabCount: Int
    @Binding var selectedQuestionIdx: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(selectedQuestionIdx == index ? .black : .black.opacity(0.3))
                    .frame(width: 5, height: 5)
                    .animation(.spring, value: selectedQuestionIdx)
            }
        }
    }
}

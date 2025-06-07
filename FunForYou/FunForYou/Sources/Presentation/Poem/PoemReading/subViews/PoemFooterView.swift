//
//  PoemFooterView.swift
//  FunForYou
//
//  Created by Woody on 6/7/25.
//

import SwiftUI

struct PoemFooterView: View {
    let isCompleted: Bool
    let poemOrderIndex: Int?
    let formattedDate: String
    
    var body: some View {
        HStack {
            if isCompleted {
                Text("\(poemOrderIndex ?? 0)번째 시")
            }
            
            Spacer()
            Text(formattedDate)
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}


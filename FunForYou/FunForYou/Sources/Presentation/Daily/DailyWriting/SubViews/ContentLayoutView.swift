//
//  ContentView.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

struct ContentLayoutView: View {
    var body: some View {
        HStack(spacing: 10) {
            Text("자세히 쓰기")
                .font(FFYFont.title3)
                .foregroundColor(FFYColor.gray3)
                .frame(alignment: .leading)
            
            Rectangle()
                .fill(FFYColor.gray1)
                .frame(height: 1)
            
        }
        .padding(.horizontal, 24)
        .padding(.top, 65)
    }
}

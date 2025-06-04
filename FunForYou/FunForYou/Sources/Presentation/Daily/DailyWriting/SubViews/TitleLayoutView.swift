//
//  TitleView.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

struct TitleLayoutView: View {
    var body: some View {
        Text("시상")
            .font(FFYFont.title3)
            .foregroundColor(FFYColor.gray3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 32)
            .padding(.horizontal, 24)
    }
}

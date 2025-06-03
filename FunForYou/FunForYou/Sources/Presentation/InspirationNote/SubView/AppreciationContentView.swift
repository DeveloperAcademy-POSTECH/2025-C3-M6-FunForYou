//
//  AppreciationContentView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import SwiftUI

struct AppreciationContentView: View {
    var appreciation: Appreciation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(appreciation.title ?? "(제목 없음)")
                .font(.title3)
                .foregroundStyle(FFYColor.black)
                .lineLimit(1)
                .padding(.bottom, 10)
            Text(appreciation.content ?? "")
                .font(.body)
                .foregroundStyle(FFYColor.black)
                .lineLimit(2)
            Spacer()
            TrailingTextView(title: "\(appreciation.date.formattedAsKoreanYMD) | 감상")
        }
        .frame(height: 110)
        .padding(.all, 25)
    }
}

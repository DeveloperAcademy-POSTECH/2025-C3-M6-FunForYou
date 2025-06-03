//
//  DailyTextContentView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import SwiftUI

struct DailyTextContentView: View {
    var image: UIImage?
    var daily: Daily
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(daily.title ?? "(제목 없음)")
                .font(.title3)
                .foregroundStyle(FFYColor.black)
                .lineLimit(1)
                .padding(.bottom, 10)
            Text(daily.content ?? "")
                .font(.body)
                .foregroundStyle(FFYColor.black)
                .lineLimit(image != nil ? 4 : 2)
            Spacer()
            TrailingTextView(title: "\(daily.date.formattedAsKoreanYMD) | 일상")
        }
    }
}

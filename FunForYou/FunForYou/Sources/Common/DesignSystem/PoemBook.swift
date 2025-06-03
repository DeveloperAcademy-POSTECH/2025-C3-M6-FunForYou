//
//  PoemBook.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

/// 공통 디자인 컴포넌트 - 완성된 시집
/// - title: "시 제목", date: Date 형태
struct PoemBook: View {
    let title: String
    let date: Date
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Text(title.forceCharWrapping)
                    .font(FFYFont.book)
                    .foregroundColor(FFYColor.black)
                    .background(.clear)
                    .frame(width: 102, alignment: .topLeading)
                    .padding(.leading, 26)
                    .padding(.trailing, 15)
                    .padding(.vertical, 21)
            }
            .frame(width: 133, height: 180, alignment: .top)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 1, green: 0.92, blue: 0.95), location: 0.30),
                        Gradient.Stop(color: Color(red: 0.86, green: 0.95, blue: 0.78), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.02, y: 0.01),
                    endPoint: UnitPoint(x: 1, y: 1)
                )
            )
            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 0, bottomLeading: 0, bottomTrailing: 15, topTrailing: 15
            )))
            
            Text(date.formattedAsKoreanDate)
                .font(FFYFont.caption1)
                .foregroundStyle(FFYColor.gray2)
        }
    }
}

#Preview {
    PoemBook(title: "마요의 산책시간", date: Date())
}

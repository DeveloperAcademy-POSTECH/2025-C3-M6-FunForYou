//
//  PoemPaper.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

/// 공통 디자인 컴포넌트 - 작성중인 시
/// - title: "시 제목", date: Date 형태
struct PoemPaper: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Text(content.forceCharWrapping)
                    .font(FFYFont.pages)
                    .foregroundColor(FFYColor.black)
                    .background(.clear)
                    .frame(width: 102, alignment: .topLeading)
                    .padding(.top, 20)
                    .padding(.bottom, 42)
                    .padding(.horizontal, 13)
            }
            .frame(width: 133, height: 180, alignment: .top)
            .background(FFYColor.craft)
            .cornerRadius(5)
            
            // TODO: - 제목 글자수제한 기획팀과 의논 후 변경사항 있다면 적용 (Berry)
            Text(String(title))
                .font(FFYFont.caption1)
                .foregroundStyle(FFYColor.gray3)
                .frame(width: 123)
                .lineLimit(1)
        }
    }
}

#Preview {
    PoemPaper(title: "제목은 열글자 까지 가능함", content: "작성 중에 임시저장한 시를 보여 줍니다. 어떤 시를 작성 중인지 볼 수 있도록 내용 텍스트를 보여줍니다. 작성 중에 임시")
}

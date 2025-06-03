//
//  InspiredPoemCardsVIew.swift
//  FunForYou
//
//  Created by 석민솔 on 6/3/25.
//

import SwiftUI

/// 이 시상으로 지은 시 섹션 서브뷰
struct InspiredPoemCardsView: View {
    // MARK: - Properties
    /// 시상 ID
    let inspirationID: String
    
    /// 해당 시상으로 쓴 시들
    let poems: [Poem]
    
    // MARK: - View
    var body: some View {
        VStack (spacing: 20) {
            // 섹션 제목 바
            HStack(alignment: .center) {
                Text("이 시상으로 지은 시")
                    .font(FFYFont.title3)
                    .foregroundStyle(FFYColor.pinkDark)
                
                Spacer()
                
                Text("\(poems.count)편")
                    .font(FFYFont.body)
                    .foregroundStyle(FFYColor.gray2)
            }
            
            // 시집 카드 그리드
            InspiredPoemCardsGridView(
                inspirationID: self.inspirationID,
                poems: self.poems
            )
            .padding(.horizontal, 15)
        }
        
    }
}

#Preview {
    InspiredPoemCardsView(
        inspirationID: "",
        poems: [
            .init(title: "무제", content: ""),
            .init(title: "무제", content: ""),
            .init(title: "무제", content: ""),
            .init(title: "무제", content: ""),
            .init(title: "무제", content: ""),
            .init(title: "무제", content: "")
        ]
    )
}

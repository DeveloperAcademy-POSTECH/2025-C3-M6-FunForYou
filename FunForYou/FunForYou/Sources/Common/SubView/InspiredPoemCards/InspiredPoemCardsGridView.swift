//
//  InspiredPoemCardsGridView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/3/25.
//

import SwiftUI

/// 이 시상으로 지은 시들 2열 카드 그리드만 있는 서브뷰
struct InspiredPoemCardsGridView: View {
    // MARK: - Properties
    /// 시상 ID
    let inspirationID: String
    
    /// 해당 시상으로 쓴 시들
    let poems: [Poem]
    
    /// 2열 그리드
    let columns = [
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.flexible(), alignment: .topTrailing)
    ]
    
    /// 해당 시상 가지고 새로운 시 쓰는 화면으로 이동하기
    var writeNewPoemButtonTapAction: () -> Void
    /// 누르면 해당 시 조회 화면으로 이동
    var readPoemButtonTapAction: (Poem) -> Void
    
    // MARK: - View
    var body: some View {
        LazyVGrid(columns: columns, spacing: 32) {
            // 새로운 시 추가 버튼
            WritePoem {
                writeNewPoemButtonTapAction()
            }
            
            // 시집 리스트
            ForEach(poems, id: \.self) { poem in
                PoemBook(title: poem.title, date: poem.date)
                    .onTapGesture {
                        readPoemButtonTapAction(poem)
                    }
            }
        }
    }
}

#Preview {
    InspiredPoemCardsGridView(
        inspirationID: "",
        poems: [
            .init(title: "무제", content: ""),
            .init(title: "무제", content: ""),
            .init(title: "무제", content: "")
        ],
        writeNewPoemButtonTapAction: {},
        readPoemButtonTapAction: {_ in }
    )
    .padding(.horizontal, 15)
    .padding(.horizontal, 24)
}

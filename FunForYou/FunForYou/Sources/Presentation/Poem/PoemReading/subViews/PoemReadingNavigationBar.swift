//
//  AppreciationReadingNavigationBar.swift
//  FunForYou
//
//  Created by 석민솔 on 6/3/25.
//

import SwiftUI

/// 시  읽기 페이지의 네비게이션 바
/// - 우측 ellipse 버튼 누르면 고쳐 쓰기, 지우기 메뉴 띄우고 기능 연결(예정)
struct PoemReadingNavigationBar: View {
    // MARK: - Properties
    var poem: Poem
    /// ellipse 버튼 눌릴 때 액션(모달 띄우는 bool 변경시키기)
    var ellipseButtonTapAction: () -> Void
    var backButtonTapAction: () -> Void

    // MARK: - View
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationBar( title: poem.isCompleted ? "시 낭독하기" : "쓰고 있는 시", style: .backTitle) {
                backButtonTapAction()
            }

            Button {
                // 모달 띄우기
                ellipseButtonTapAction()
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundStyle(FFYColor.pinkDark)
                    .padding(.bottom)
                    .padding(.trailing, 24)
            }

        }
    }
}

#Preview {
    PoemReadingNavigationBar(
        poem: samplePoem, 
        ellipseButtonTapAction: {},
        backButtonTapAction: {}
    )
}

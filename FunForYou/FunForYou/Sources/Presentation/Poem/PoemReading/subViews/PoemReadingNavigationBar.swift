//
//  AppreciationReadingNavigationBar.swift
//  FunForYou
//
//  Created by 석민솔 on 6/3/25.
//

import SwiftUI

/// 시  읽기 페이지의 네비게이션 바
/// - 우측 ellipse 버튼 누르면 고쳐 쓰기, 지우기 메뉴 띄움
struct PoemReadingNavigationBar: View {
    // MARK: - Properties
    var isPoemCompleted: Bool
    var editButtonTapAction: () -> Void
    var deleteButtonTapAction: () -> Void
    var backButtonTapAction: () -> Void

    // MARK: - View
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationBar(
                title: isPoemCompleted ? "시 낭독하기" : "쓰고 있는 시",
                style: .backTitle,
                onBack: {
                    backButtonTapAction()
                }
            )

            Menu {
                // 고쳐 쓰기
                Button {
                    editButtonTapAction()
                } label: {
                    Text("고쳐 쓰기")
                }
                
                // 지우기
                Button(role: .destructive) {
                    deleteButtonTapAction()
                } label: {
                    Text("지우기")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundStyle(FFYColor.pinkDark)
                    .padding(.bottom)
                    .padding(.trailing, 24)
            }
            .contentShape(Circle())
        }
    }
}

#Preview {
    PoemReadingNavigationBar(
        isPoemCompleted: samplePoem.isCompleted,
        editButtonTapAction: {},
        deleteButtonTapAction: {},
        backButtonTapAction: {}
    )
}

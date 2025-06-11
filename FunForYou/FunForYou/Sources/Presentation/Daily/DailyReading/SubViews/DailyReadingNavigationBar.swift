//
//  DailyReadingNavigationBar.swift
//  FunForYou
//
//  Created by 배현진 on 6/4/25.
//
import SwiftUI

/// 일상 읽기 네비게이션 바
struct DailyReadingNavigationBar: View {
    // MARK: - Properties
    var backButtonTapAction: () -> Void
    var editButtonTapAction: () -> Void
    var deleteButtonTapAction: () -> Void
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationBar(
                title: "일상 읽기",
                style: .backTitle
            ) {
                backButtonTapAction()
            }
            
            Menu {
                // 고쳐 쓰기
                Button {
                    // 일상 편집 페이지로 이동
                    editButtonTapAction()
                } label: {
                    Text("고쳐 쓰기")
                }
                
                // 지우기
                Button(role: .destructive) {
                    // 정말 지우겠냐는 alert 띄우기
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
        }
    }
}

#Preview {
    DailyReadingNavigationBar(backButtonTapAction: {}, editButtonTapAction: {}, deleteButtonTapAction: {})
}

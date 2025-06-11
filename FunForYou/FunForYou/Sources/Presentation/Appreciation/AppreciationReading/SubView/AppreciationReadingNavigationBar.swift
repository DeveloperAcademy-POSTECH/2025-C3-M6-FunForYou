//
//  AppreciationReadingNavigationBar.swift
//  FunForYou
//
//  Created by 석민솔 on 6/3/25.
//

import SwiftUI

/// 감상 읽기 페이지의 네비게이션 바
/// - 우측 ellipse 버튼 누르면 고쳐 쓰기, 지우기 메뉴 띄우고 기능 연결(예정)
struct AppreciationReadingNavigationBar: View {
    // MARK: - Properties
    /// 화면 dismiss시키기
    var backButtonTapAction: () -> Void
    /// 고쳐쓰기 버튼 눌렀을 때: 감상 페이지로 이동
    var editButtonTapAction: () -> Void
    /// 지우기 버튼 눌렀을 때: 삭제 alert 띄우기
    var deleteButtonTapAction: () -> Void
    
        
    // MARK: - View
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationBar(title: "감상 읽기", style: .backTitle) {
                backButtonTapAction()
            }
            
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

        }
    }
}

#Preview {
    AppreciationReadingNavigationBar(backButtonTapAction: {}, editButtonTapAction: {}, deleteButtonTapAction: {})
}

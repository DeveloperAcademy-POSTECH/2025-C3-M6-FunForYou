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
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationBar(title: "감상 읽기", style: .backTitle)
            
            Menu {
                // 고쳐 쓰기
                Button {
                    // TODO: 감상 편집 페이지로 이동(ssol)
                } label: {
                    Text("고쳐 쓰기")
                }
                
                // 지우기
                Button(role: .destructive) {
                    // TODO: 정말 지우겠냐는 alert 띄우고 액션 연결하기(ssol)
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
    AppreciationReadingNavigationBar()
}

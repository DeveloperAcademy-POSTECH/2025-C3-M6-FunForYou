//
//  DailyReadingNavigationBar.swift
//  FunForYou
//
//  Created by 배현진 on 6/4/25.
//
import SwiftUI

/// 일상 읽기 네비게이션 바
struct DailyReadingNavigationBar: View {
    var backButtonTapAction: () -> Void
    var ellipseButtonTapAction: () -> Void
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationBar(
                title: "일상 읽기",
                style: .backTitle
            ) {
                backButtonTapAction()
            }
            
            Button {
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
    DailyReadingNavigationBar(backButtonTapAction: {}, ellipseButtonTapAction: {})
}

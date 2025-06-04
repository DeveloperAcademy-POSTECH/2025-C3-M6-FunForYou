//
//  DailyReadingNavigationBar.swift
//  FunForYou
//
//  Created by 배현진 on 6/4/25.
//
import SwiftUI

struct DailyReadingNavigationBar: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationBar(
                title: "일상 읽기",
                style: .backTitle,
                onBack: {
                    dismiss()
                }
            )
            
            Menu {
                Button {
                    // TODO: 감상 편집 페이지로 이동(berry)
                } label: {
                    Text("고쳐 쓰기")
                }
                
                Button(role: .destructive) {
                    // TODO: 정말 지우겠냐는 alert 띄우고 액션 연결하기(berry)
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

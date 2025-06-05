//
//  DailyReadingNavigationBar.swift
//  FunForYou
//
//  Created by 배현진 on 6/4/25.
//
import SwiftUI

struct DailyReadingNavigationBar: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: DailyReadingViewModel
    
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
                    viewModel.action(.editButtonTapped)
                } label: {
                    Text("고쳐 쓰기")
                }
                
                Button(role: .destructive) {
                    viewModel.action(.deleteButtonTapped)
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

//
//  SelectInspiration.swift
//  FunForYou
//
//  Created by Woody on 6/2/25.

import SwiftUI

import SwiftUI

struct SelectInspiration: View {
    @ObservedObject var viewModel: PoemWritingViewModel
    @State private var isInspirationSheetPresented = false
    @State private var isDailyReadingSheetPresented = false
    @State private var isAppreciationReadingSheetPresented = false

    var body: some View {
        HStack {
            Text("시상")
                .font(FFYFont.headline)
                .foregroundColor(FFYColor.gray3)
                .padding(.trailing,30)

            SelectedTextButton(
                title: viewModel.state.selectedInspiration?.title
                    ?? "눌러서 불러올 수 있어요",
                systemImage: "chevron.up.chevron.down",
                imageOnRight: true,
                viewModel: viewModel
            ) {
                print("시상 불러오기")
                isInspirationSheetPresented = true
            }
            .sheet(isPresented: $isInspirationSheetPresented) {
                InspirationSelectionSheet(viewModel: viewModel)
            }
            
            Spacer()

            // 시상 읽기 버튼
            if viewModel.state.selectedInspiration != nil {
                SubButton(title: "시상 읽기", style: .basic) {
                    switch viewModel.state.poem.type {
                    case .daily:
                        isDailyReadingSheetPresented = true
                    case .appreciation:
                        isAppreciationReadingSheetPresented = true
                    case .none:
                        print("⚠️ type이 정의되지 않음")
                    }
                }
            } else {
                SubButton(title: "시상 읽기", style: .disable)
            }
        }
        .padding(.horizontal,30)
        .padding(.bottom,20)
        // Daily 시트
        .sheet(isPresented: $isDailyReadingSheetPresented) {
            if let daily = viewModel.state.selectedInspiration as? Daily {
                DailyReadingSheet(daily: daily)
            } else {
                Text("잘못된 시상 타입입니다.")
            }
        }
        // Appreciation 시트
        .sheet(isPresented: $isAppreciationReadingSheetPresented) {
            if let appreciation = viewModel.state.selectedInspiration as? Appreciation {
                AppreciationReadingSheet(appreciation: appreciation)
            } else {
                Text("잘못된 시상 타입입니다.")
            }
        }
    }
}


//
//  SelectInspiration.swift
//  FunForYou
//
//  Created by Woody on 6/2/25.

import SwiftUI

struct SelectInspiration: View {
    @ObservedObject var viewModel: PoemWritingViewModel
    @State private var isInspirationSheetPresented = false
    @State private var isReadingSheetPresented = false

    var body: some View {
        HStack {
            Text("시상")
                .font(FFYFont.headline)
                .foregroundColor(FFYColor.gray3)
                .padding(.trailing, 30)

            SelectedTextButton(
                systemImage: "chevron.up.chevron.down",
                imageOnRight: true,
                viewModel: viewModel
            ) {
                isInspirationSheetPresented = true
            }
            .sheet(isPresented: $isInspirationSheetPresented) {
                InspirationSelectionSheet(viewModel: viewModel)
            }

            Spacer()

            if viewModel.state.selectedInspiration != nil {
                SubButton(title: "시상 읽기", style: .basic) {
                    isReadingSheetPresented = true
                }
            } else {
                SubButton(title: "시상 읽기", style: .disable)
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 20)
        .sheet(isPresented: $isReadingSheetPresented) {
            if let inspiration = viewModel.state.selectedInspiration {
                InspirationReadingSheet(inspiration: inspiration)
            } else {
                Text("잘못된 시상 타입입니다.")
            }
        }
    }
}



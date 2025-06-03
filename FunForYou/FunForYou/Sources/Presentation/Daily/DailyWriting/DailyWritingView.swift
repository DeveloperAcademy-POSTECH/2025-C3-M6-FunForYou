//
//  DailyWritingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct DailyWritingView: View {
    @StateObject var viewModel: DailyWritingViewModel
    
    init(daily: Daily?, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: DailyWritingViewModel(daily: daily, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            NavigationBar(title: "일상 쓰기", style: .backTitleButton(title: "저장하기", isEnabled: viewModel.state.isSaveEnabled) {
                // TODO: - 저장하기 버튼 클릭 시점의 데이터 저장과 화면전환 (Berry)
                viewModel.action(.saveDailyInspiration)
            })
            
            DailyWritingContentView(
                dailyTitle: $viewModel.state.dailyTitle,
                dailyContent: $viewModel.state.dailyContent,
                isShowImagePicker: $viewModel.state.isShowImagePicker,
                selectedImage: $viewModel.state.selectedImage
            )
        }
        .sheet(isPresented: $viewModel.state.isShowImagePicker) {
            PhotoPicker(selectedImage: $viewModel.state.selectedImage)
        }
        .hideKeyboardOnTap()
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    @Previewable @State var searchText = ""
    
    DailyWritingView(daily: Daily.mockData, coordinator: coordinator)
}

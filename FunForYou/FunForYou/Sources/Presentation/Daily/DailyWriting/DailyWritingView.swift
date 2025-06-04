//
//  DailyWritingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct DailyWritingView: View {
    @StateObject var viewModel: DailyWritingViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    init(daily: Daily?, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: DailyWritingViewModel(daily: daily, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            NavigationBar(
                title: "일상 쓰기",
                style: .backTitleButton(
                    title: "저장하기",
                    isEnabled: viewModel.state.isSaveEnabled
                ) { viewModel.action(.saveDailyInspiration(context)) },
                onBack: {
                    if viewModel.state.isSaveEnabled {
                        viewModel.state.isShowAlert = true
                    } else {
                        dismiss()
                    }
                }
            )
            
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
        .overlay {
            if viewModel.state.isShowAlert {
                PrimaryAlert(
                    style: .deleteInspiration,
                    onPrimary: {
                        dismiss()
                    },
                    onSecondary: {
                        viewModel.state.isShowAlert = false
                    },
                    isVisible: $viewModel.state.isShowAlert
                )
            }
        }
        .hideKeyboardOnTap()
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    @Previewable @State var searchText = ""
    
    DailyWritingView(daily: Daily.mockData, coordinator: coordinator)
}

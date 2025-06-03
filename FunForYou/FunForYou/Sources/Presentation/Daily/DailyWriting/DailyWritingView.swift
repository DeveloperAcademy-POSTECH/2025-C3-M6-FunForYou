//
//  DailyWritingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct DailyWritingView: View {
    @StateObject var viewModel: DailyWritingViewModel
    @State private var dailyTitle: String = ""
    @State private var dailyContent: String = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    
    var isSaveEnabled: Bool {
        !dailyTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        !dailyContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    init(daily: Daily?, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: DailyWritingViewModel(daily: daily, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            NavigationBar(title: "일상 쓰기", style: .backTitleButton(title: "저장하기", isEnabled: isSaveEnabled) {
                // TODO: - 저장하기 버튼 클릭 시점의 데이터 저장과 화면전환 (Berry)
            })
            
            DailyWritingContentView(
                dailyTitle: $dailyTitle,
                dailyContent: $dailyContent,
                isShowImagePicker: $showImagePicker,
                selectedImage: $selectedImage
            )
        }
        .sheet(isPresented: $showImagePicker) {
            // TODO: - 이미지 picker 구현해서 띄우기
        }
        .hideKeyboardOnTap()
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    @Previewable @State var searchText = ""
    
    DailyWritingView(daily: Daily.mockData, coordinator: coordinator)
}

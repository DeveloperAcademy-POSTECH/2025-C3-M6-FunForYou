//
//  DailyReadingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

/// 일상 읽기 뷰
struct DailyReadingView: View {
    @StateObject var viewModel: DailyReadingViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(daily: Daily, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: DailyReadingViewModel(daily: daily, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            DailyReadingNavigationBar()
            
            ScrollView {
                DailyReadingContentView(
                    title: viewModel.state.daily.title,
                    content: viewModel.state.daily.content,
                    imagePath: viewModel.state.daily.image
                )
                
                InspiredPoemCardsView(
                    inspirationID: viewModel.state.daily.id,
                    poems: viewModel.state.inspiredPoems
                )
                .padding(.top, 64)
                .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    
    DailyReadingView(daily: Daily.mockData, coordinator: coordinator)
}

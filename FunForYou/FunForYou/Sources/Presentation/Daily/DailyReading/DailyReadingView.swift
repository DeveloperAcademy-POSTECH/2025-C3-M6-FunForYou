//
//  DailyReadingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct DailyReadingView: View {
    @StateObject var viewModel: DailyReadingViewModel
    
    init(daily: Daily, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: DailyReadingViewModel(daily: daily, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

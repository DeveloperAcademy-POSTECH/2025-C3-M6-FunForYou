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
            
        }
    }
}

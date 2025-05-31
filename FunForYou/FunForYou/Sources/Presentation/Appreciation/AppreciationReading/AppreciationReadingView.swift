//
//  AppreciationReadingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct AppreciationReadingView: View {
    @StateObject var viewModel: AppreciationReadingViewModel
    
    init(appreciation: Appreciation, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: AppreciationReadingViewModel(appreciation: appreciation, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

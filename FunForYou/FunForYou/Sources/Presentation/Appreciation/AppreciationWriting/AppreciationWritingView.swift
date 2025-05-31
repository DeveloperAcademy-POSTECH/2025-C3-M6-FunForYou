//
//  AppreciationWritingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//
import SwiftUI

struct AppreciationWritingView: View {
    @StateObject var viewModel: AppreciationWritingViewModel
    
    init(appreciation: Appreciation?, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: AppreciationWritingViewModel(appreciation: appreciation, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

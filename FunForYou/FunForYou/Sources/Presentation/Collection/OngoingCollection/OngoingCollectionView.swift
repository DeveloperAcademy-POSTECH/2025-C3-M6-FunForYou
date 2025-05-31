//
//  OngoingCollectionView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct OngoingCollectionView: View {
    @StateObject var viewModel: OngoingCollectionViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: OngoingCollectionViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

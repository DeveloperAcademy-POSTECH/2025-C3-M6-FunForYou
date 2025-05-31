//
//  CompleteCollectionView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct CompleteCollectionView: View {
    @StateObject var viewModel: CompleteCollectionViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: CompleteCollectionViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

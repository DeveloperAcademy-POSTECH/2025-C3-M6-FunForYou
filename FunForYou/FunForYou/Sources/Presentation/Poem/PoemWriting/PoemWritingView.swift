//
//  PoemWritingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct PoemWritingView: View {
    @StateObject var viewModel: PoemWritingViewModel
    
    init(poem: Poem?, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: PoemWritingViewModel(poem: poem, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

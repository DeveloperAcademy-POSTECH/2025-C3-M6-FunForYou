//
//  PoemReadingView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct PoemReadingView: View {
    @StateObject var viewModel: PoemReadingViewModel
    
    init(poem: Poem, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: PoemReadingViewModel(poem: poem, coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

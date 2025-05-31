//
//  InspirationNoteView.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import SwiftUI

struct InspirationNoteView: View {
    @StateObject var viewModel: InspirationNoteViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: InspirationNoteViewModel(coordinator: coordinator))
    }
    
    
    var body: some View {
        VStack {
            
        }
    }
}

//
//  PoemTitleField.swift
//  FunForYou
//
//  Created by Woody on 6/2/25.
//

import SwiftUI

struct PoemTitleField: View {
    @ObservedObject var viewModel: PoemWritingViewModel

    var body: some View {
        TextField(
            "시 제목",
            text: $viewModel.state.poem.title
        )
        .font(FFYFont.title)
        .lineLimit(1)
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
        .onChange(of: viewModel.state.poem.title) { newValue in
            if newValue.count > 15 {
                viewModel.state.poem.title = String(newValue.prefix(15))
            }
        }
       

    }
    
}

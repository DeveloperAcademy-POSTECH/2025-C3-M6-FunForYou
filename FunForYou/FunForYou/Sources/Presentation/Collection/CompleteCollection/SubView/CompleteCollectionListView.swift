//
//  CompleteCollectionListView.swift
//  FunForYou
//
//  Created by 한건희 on 6/4/25.
//

import SwiftUI

struct CompleteCollectionListView: View {
    var poems: [Poem]
    var continueWriteButtonTapAction: () -> Void
    var ongoingPoemCount: Int
    var completePoemTapAction: (String) -> Void
    
    var body: some View {
        ScrollView {
            Spacer().frame(height: 20)
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 100, maximum: 400)),
                GridItem(.flexible(minimum: 100, maximum: 400))
            ]) {
                PoemPaperSet(paperCount: ongoingPoemCount) {
                    continueWriteButtonTapAction()
                }
                .padding(.bottom, 32)
                
                ForEach(poems, id: \.self) { poem in
                    PoemBook(
                        title: poem.title.isEmpty ? "무제" : poem.title,
                        date: poem.date
                    )
                    .onTapGesture {
                        completePoemTapAction(poem.id)
                    }
                    .padding(.bottom, 32)
                }
            }
        }
    }
}

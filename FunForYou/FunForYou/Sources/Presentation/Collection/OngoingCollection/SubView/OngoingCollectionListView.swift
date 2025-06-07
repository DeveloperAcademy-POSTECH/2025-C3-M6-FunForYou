//
//  OngoingCollectionListView.swift
//  FunForYou
//
//  Created by KIM, SoonJoo on 6/4/25.
//

import SwiftUI

struct OngoingCollectionListView: View {
    var poems: [Poem]
    var ongoingPoemTapAction: (Poem) -> Void
    
    var body: some View {
        ScrollView {
            Spacer().frame(height: 20)
            LazyVGrid(columns: [
                GridItem(.flexible(), alignment: .leading),
                GridItem(.flexible(), alignment: .trailing)
            ]) {
                ForEach(poems, id: \.self) { poem in
                    PoemPaper(
                     title: poem.title.isEmpty ? "무제" : poem.title,
                     content: poem.content.isEmpty ? "(내용이 없어요)" : poem.content
                    )
                    .onTapGesture {
                        ongoingPoemTapAction(poem)
                    }
                    .padding(.bottom, 32)
                }
            }
        }
    }
}

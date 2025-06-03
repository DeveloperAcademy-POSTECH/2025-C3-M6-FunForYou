//
//  QuestionCarouselView.swift
//  FunForYou
//
//  Created by 한건희 on 6/2/25.
//

import SwiftUI

struct QuestionCarouselView: View {
    @Binding var questions: [String]
    @Binding var selectedQuestionIdx: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(FFYColor.pinkLight)
            .frame(height: 90)
            .overlay(
                VStack(spacing: 0) {
                    TabView(selection: $selectedQuestionIdx) {
                        SingleInspirationQuestionView(question: questions[0])
                        .tag(0)
                        SingleInspirationQuestionView(question: questions[1])
                        .tag(1)
                        SingleInspirationQuestionView(question: questions[2])
                        .tag(2)
                    }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    TabIndicatorView(tabCount: 3, selectedQuestionIdx: $selectedQuestionIdx)
                        .padding(.bottom, 10)
                }
                
            )
        .padding(.horizontal, 24)
    }
}


#Preview {
    @Previewable @State var questions: [String] = ["question 1question 1question 1question 1question 1question 1question 1question 1question 1question 1question 1question 1question 1question 1", "question 2", "question 3"]
    @Previewable @State var selectedQuestionIdx: Int = 0
    
    QuestionCarouselView(questions: $questions, selectedQuestionIdx: $selectedQuestionIdx)
}

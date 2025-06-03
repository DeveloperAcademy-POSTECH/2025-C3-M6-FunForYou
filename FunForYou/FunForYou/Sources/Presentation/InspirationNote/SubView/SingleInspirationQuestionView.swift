//
//  SingleInspirationQuestionView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//
import SwiftUI

struct SingleInspirationQuestionView: View {
    var question: String
    
    var body: some View {
        HStack {
            Image(systemName: "burst.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
                .foregroundStyle(FFYColor.pinkDark)
                .padding(.leading, 17)
            
            Spacer().frame(width: 8)
            
            Text(question)
                .font(FFYFont.body)
                .foregroundStyle(FFYColor.gray3)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            
            Spacer()
        }
    }
}

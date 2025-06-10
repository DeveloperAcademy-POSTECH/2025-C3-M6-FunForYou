//
//  QuoteMarkView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/3/25.
//

import SwiftUI

/// 마음의 한마디 따옴표와 함께 보여주는 서브뷰
struct QuoteMarkView: View {
    /// 따옴표 안쪽에 들어갈 마음의 한마디
    var title: String?
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("double-quotes-l")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let title {
                Text(title)
                    .font(FFYFont.title3)
                    .foregroundStyle(FFYColor.black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Image("double-quotes-r")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    QuoteMarkView(title: nil)
}

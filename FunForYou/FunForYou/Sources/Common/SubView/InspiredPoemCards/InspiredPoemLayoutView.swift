//
//  InspiredPoemLayoutView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/5/25.
//

import SwiftUI

/// 이 시상으로 지은 시 제목 바
struct InspiredPoemLayoutView: View {
    // MARK: - Properties
    let poemCount: Int
    
    // MARK: - View
    var body: some View {
        // 섹션 제목 바
        HStack(alignment: .center) {
            Text("이 시상으로 지은 시")
                .font(FFYFont.title3)
                .foregroundStyle(FFYColor.pinkDark)
            
            Spacer()
            
            Text("\(poemCount)편")
                .font(FFYFont.body)
                .foregroundStyle(FFYColor.gray2)
        }
    }
}

#Preview {
    InspiredPoemLayoutView(poemCount: 4)
}

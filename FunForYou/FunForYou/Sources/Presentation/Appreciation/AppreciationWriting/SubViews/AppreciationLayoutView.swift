//
//  AppreciationLayoutView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/4/25.
//

import SwiftUI

/// 내 감상 쓰기랑 구분선 있는 뷰
struct AppreciationLayoutView: View {
    var body: some View {
        HStack(spacing: 10) {
            Text("내 감상 쓰기")
                .font(FFYFont.title3)
                .foregroundStyle(FFYColor.gray3)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundStyle(FFYColor.gray1)
        }
    }
}

#Preview {
    AppreciationLayoutView()
}

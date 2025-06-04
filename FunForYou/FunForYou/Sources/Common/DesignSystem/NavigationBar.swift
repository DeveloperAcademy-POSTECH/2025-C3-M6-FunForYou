//
//  NavigationBar.swift
//  FunForYou
//
//  Created by 배현진 on 6/2/25.
//

import SwiftUI

/// 공통 디자인 컴포넌트 - Navigation Bar
/// - 뒤로가기 버튼만  - title: nil, style: .back
/// - 뒤로가기 버튼 + 타이틀 - title: "바제목", style: .backTitle
/// - 뒤로가기 버튼 + 타이틀 + 활성버튼 - title: "바제목", style: .backTitleButton(title: "버튼이름", isEnabled: true, action: { }), onBack: { }
/// - 뒤로가기 버튼 + 타이틀 + 비활성버튼 - title: "바제목", style: .backTitleButton(title: "버튼이름", isEnabled: false, action: { }), onBack: { }
struct NavigationBar: View {
    @Environment(\.dismiss) private var dismiss
    
    let title: String?
    let style: NavigationStyleType
    var onBack: (() -> Void)?
    
    init(title: String? = nil,
         style: NavigationStyleType,
         onBack: (() -> Void)? = nil
    ) {
        self.title = title
        self.style = style
        self.onBack = onBack
    }
    
    var body: some View {
        VStack {
            ZStack {
                if let title = title {
                    Text(title)
                        .font(FFYFont.headline)
                        .foregroundColor(FFYColor.black)
                }
                
                HStack {
                    Button(action: {
                        onBack?()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12)
                            .foregroundColor(FFYColor.pinkDark)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    trallingButton()
                }
                .padding(.horizontal, 24)
            }
            Divider()
        }
    }
    
    @ViewBuilder
    private func trallingButton() -> some View {
        switch style {
        case .back, .backTitle:
            Color.clear.frame(width: 44, height: 22)
        case let .backTitleButton(title, isEnabled, action):
            Button(action: {
                if isEnabled { action() }
            }) {
                Text(title)
                    .font(FFYFont.headline)
                    .foregroundColor(isEnabled ? FFYColor.pinkDark : FFYColor.gray1)
            }
            .disabled(!isEnabled)
                .animation(.easeInOut, value: isEnabled)
        }
    }
}

#Preview {
    NavigationBar(title: nil, style: .back)
    NavigationBar(title: "타이틀만", style: .backTitle)
    NavigationBar(title: "시 쓰기", style: .backTitleButton(title: "임시보관", isEnabled: true, action: {
        print("저장 하기 클릭")
    }))
    NavigationBar(title: "시 쓰기", style: .backTitleButton(title: "임시보관", isEnabled: false, action: {
        print("저장 하기 클릭")
    }))
}

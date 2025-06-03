//
//  SubButton.swift
//  FunForYou
//
//  Created by 배현진 on 6/1/25.
//
import SwiftUI

/// 공통 디자인 컴포넌트 - 작은 버튼 (텍스트, 스타일, 액션 입력 필요합니다.)
/// - 활성 상태 핑크ver  - title: "", style: .basic,  { 액션 클로저 구현 }
/// - 활성 상태 진회색ver  - title: "", style: .sub,  { 액션 클로저 구현 }
/// - 비활성 상태 - title: "", style: .disable
struct SubButton: View {
    let title: String
    let style: SubButtonStyle
    let action: (() -> Void)?
    
    init(title: String,
         style: SubButtonStyle,
         action: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    private var buttonLabel: some View {
        return Text(title)
            .frame(width: 76, height: 24)
            .font(FFYFont.subHeadline)
            .foregroundColor(style.textColor)
            .background(style.backgroundColor)
            .cornerRadius(40)
    }
    
    var body: some View {
        Button(action: {
            if let action = action {
                action()
            }
        }, label: {
            buttonLabel
        })
        .disabled(!style.isEnable)
    }
}

#Preview {
    // basic 버튼
    SubButton(title: "활성화", style: .basic) {
        print("필요한 버튼 액션 구현")
    }
    // sub 버튼
    SubButton(title: "활성화", style: .sub) {
        print("필요한 버튼 액션 구현")
    }
    // disable 버튼
    SubButton(title: "비활성화", style: .disable) {
        // 활성, 비활성 통일성을 주고 싶다면 작성을 유지하고 style 조건만 처리해도되고,
        // 아니라면 클로저({ }부분)를 아예 작성하지 않아도 됩니다.
        print("어차피 동작 안해요")
    }
}

//
//  WritePoem.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

/// 공통 디자인 컴포넌트 - 새로운 시 짓기
/// - 클릭 시점의 액션만 후행 클로저 형태로 작성  { }
struct WritePoem: View {
    let onClick: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 9) {
            Text("새로운\n시 짓기")
                .font(FFYFont.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(FFYColor.gray3)
            
            Text("+")
                .font(Font.custom("SF Pro Display", size: 40))
                .foregroundColor(FFYColor.gray3)
        }
        .padding(.horizontal, 15.5)
        .padding(.top, 39)
        .padding(.bottom, 42)
        .frame(width: 133, height: 180, alignment: .center)
        .background(FFYColor.green)
        .cornerRadius(20)
        .opacity(isPressed ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 0.3), value: isPressed)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    isPressed = true
                }
                .onEnded { _ in
                    isPressed = false
                    onClick()
                }
        )
    }
}

#Preview {
    WritePoem() { print("클릭") }
}

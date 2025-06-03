//
//  PoemPaperSet.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

/// 공통 디자인 컴포넌트 - 작성중인 시 이어쓰기
/// - paperCount: 0 (총 작성중인 시 개수 Int 형)
struct PoemPaperSet: View {
    let paperCount: Int
    let onClick: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image("PoemPaperSet")
                .resizable()
                .frame(width: 147, height: 180)
                .aspectRatio(contentMode: .fit)
            
            Text("쓰고 있는 시 \(paperCount)편")
                .font(FFYFont.caption1)
                .foregroundStyle(FFYColor.gray2)
        }
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
    PoemPaperSet(paperCount: 5) { print("클릭됨") }
}

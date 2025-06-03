//
//  PrimaryAlert.swift
//  FunForYou
//
//  Created by 배현진 on 6/2/25.
//
import SwiftUI
 
/// 공통 디자인 컴포넌트 - CustomAlert (텍스트까지 입력 되어 있습니다. 스타일, 액션 입력 필요합니다.)
/// - 이전 화면 이동  - style: .basic,  onPrimary: { }, onSecondary: { }
/// - 시상 삭제 - style: .deleteInspiration,  onPrimary: { }, onSecondary: { }
/// - 시 삭제 - style: .deletePoem,  onPrimary: { }, onSecondary: { }
struct PrimaryAlert: View {
    let style: AlertStyleType
    let onPrimary: () -> Void
    let onSecondary: () -> Void
    
    @State private var isVisible = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
                .transition(.opacity)
            VStack {
                Text(style.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top, 19)
                Text(style.content)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                VStack {
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            onPrimary()
                        }
                    }) {
                        Text(style.primaryTitle)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                    }
                    
                    Divider()
                    
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            onSecondary()
                        }
                    }) {
                        Text(style.secondaryTitle)
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .padding(.bottom, 10)
                    }
                }
            }
            .background(FFYColor.grayAlert)
            .cornerRadius(14)
            .frame(width: 270, height: 166)
            .scaleEffect(isVisible ? 1 : 0.8)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.easeOut(duration: 0.2)) {
                    isVisible = true
                }
            }
        }
    }
}

#Preview {
    PrimaryAlert(
        style:.basic,
        onPrimary: {
            print("아니요, 계속 쓸래요")
        },
        onSecondary: {
            print("네, 이전으로 돌아갈게요")
        }
    )
}

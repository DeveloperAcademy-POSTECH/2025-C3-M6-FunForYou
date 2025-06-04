//
//  TopMenuModal.swift
//  FunForYou
//
//  Created by 한건희 on 6/4/25.
//
import SwiftUI

struct TopMenuModal: View {
    @Binding var showModal: Bool
    var modalStyle: TopModalStyleType
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.thinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.4))
            )
            .frame(width: 230, height: modalStyle.buttonHeight * 2)
            .overlay(
                VStack(spacing: 0) {
                    TopMenuModalButton(
                        tapAction: modalStyle.firstButtonTapAction,
                        title: modalStyle.firstButtonText,
                        color: modalStyle.firstButtonTextColor
                    )
                    .frame(height: modalStyle.buttonHeight)
                    Rectangle()
                        .fill(FFYColor.gray1)
                        .frame(height: 1)
                    TopMenuModalButton(
                        tapAction: modalStyle.secondButtonTapAction,
                        title: modalStyle.secondButtonText,
                        color: modalStyle.secondButtonTextColor
                    )
                    .frame(height: modalStyle.buttonHeight)
                }
            )
            .clipped()
            .shadow(radius: 12)
            .opacity(showModal ? 1 : 0)
            .disabled(!showModal)
            .animation(.spring, value: showModal)
    }
}

struct TopMenuModalButton: View {
    var tapAction: () -> Void
    var title: String
    var color: Color
    
    var body: some View {
        Button(action: {
            tapAction()
        }) {
            HStack {
                Spacer()
                Text(title)
                    .foregroundStyle(color)
                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var showModal: Bool = true
    TopMenuModal(
        showModal: $showModal,
        modalStyle: .appreciationReadingTop(
            modify: {
                // modify action
            },
            delete: {
                // delete action
            }
        )
    )
}

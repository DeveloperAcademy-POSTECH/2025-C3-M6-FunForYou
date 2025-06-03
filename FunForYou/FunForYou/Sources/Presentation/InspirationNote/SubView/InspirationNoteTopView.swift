//
//  InspirationNoteTopView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//
import SwiftUI

struct InspirationNoteTopView: View {
    var writeInspirationButtonTapAction: () -> Void
    var writeDailyButtonTapAction: () -> Void
    var writeAppreciationButtonTapAction: () -> Void
    @Binding var showWriteModal: Bool
    
    init(
        writeInspirationButtonTapAction: @escaping () -> Void,
        writeDailyButtonTapAction: @escaping () -> Void,
        writeAppreciationButtonTapAction: @escaping () -> Void,
        showWriteModal: Binding<Bool>
    ) {
        self.writeInspirationButtonTapAction = writeInspirationButtonTapAction
        self.writeDailyButtonTapAction = writeDailyButtonTapAction
        self.writeAppreciationButtonTapAction = writeAppreciationButtonTapAction
        self._showWriteModal = showWriteModal
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            InspirationNoteTopContentView(
                writeInspirationButtonTapAction: writeInspirationButtonTapAction
            )
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.thinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white.opacity(0.4))
                )
                .frame(width: 230, height: 88)
                .overlay(
                    VStack(spacing: 0) {
                        Button(action: {
                            writeDailyButtonTapAction()
                        }) {
                            HStack {
                                Spacer().frame(width: 20)
                                Text("일상 이야기에요")
                                Spacer()
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(height: 44)
                        Rectangle()
                            .fill(FFYColor.gray1)
                            .frame(height: 1)
                        Button(action: {
                            writeAppreciationButtonTapAction()
                        }) {
                            Spacer().frame(width: 20)
                            Text("감상한 콘텐츠가 있어요")
                            Spacer()
                        }
                        .buttonStyle(.plain)
                        .frame(height: 44)
                    }
                )
                .clipped()
                .shadow(radius: 12)
                .opacity(showWriteModal ? 1 : 0)
                .disabled(!showWriteModal)
                .animation(.spring, value: showWriteModal)
        }
        .frame(height: 58, alignment: .top)
        .zIndex(100)
        .padding(.horizontal, 24)
    }
}

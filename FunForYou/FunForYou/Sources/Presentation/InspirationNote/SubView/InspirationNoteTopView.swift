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
            
            TopMenuModal(
                showModal: $showWriteModal,
                modalStyle: .inspirationTop(
                    daily: {
                        writeDailyButtonTapAction()
                    },
                    appreciation: {
                        writeAppreciationButtonTapAction()
                    }
                )
            )
        }
        .frame(height: 58, alignment: .top)
        .padding(.horizontal, 24)
        .zIndex(100)
    }
}


//
//  DailyReadingTopView.swift
//  FunForYou
//
//  Created by 배현진 on 6/8/25.
//
import SwiftUI

/// 일상 읽기 네비게이션 바 + 커스텀 메뉴(모달)
struct DailyReadingTopView: View {
    var backButtonTapAction: () -> Void
    var ellipseButtonTapAction: () -> Void
    var editButtonTapAction: () -> Void
    var deleteButtonTapAction: () -> Void
    @Binding var showModal: Bool
    
    init(
        backButtonTapAction: @escaping () -> Void,
        ellipseButtonTapAction: @escaping () -> Void,
        editButtonTapAction: @escaping () -> Void,
        deleteButtonTapAction: @escaping () -> Void,
        showModal: Binding<Bool>
    ) {
        self.backButtonTapAction = backButtonTapAction
        self.ellipseButtonTapAction = ellipseButtonTapAction
        self.editButtonTapAction = editButtonTapAction
        self.deleteButtonTapAction = deleteButtonTapAction
        self._showModal = showModal
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            // 네비게이션 바
//            DailyReadingNavigationBar(
//                backButtonTapAction: backButtonTapAction,
//                ellipseButtonTapAction: ellipseButtonTapAction
//            )
            
            // 메뉴 모달
            TopMenuModal(
                showModal: $showModal,
                modalStyle: .defaultTop(
                    modify: {
                        editButtonTapAction()
                    },
                    delete: {
                        deleteButtonTapAction()
                    }
                )
            )
            .padding(.horizontal, 20)
        }
        .frame(height: 35, alignment: .top)
        .zIndex(100)
    }

}

#Preview {
    DailyReadingTopView(backButtonTapAction: {}, ellipseButtonTapAction: {}, editButtonTapAction: {}, deleteButtonTapAction: {}, showModal: .constant(true))
}

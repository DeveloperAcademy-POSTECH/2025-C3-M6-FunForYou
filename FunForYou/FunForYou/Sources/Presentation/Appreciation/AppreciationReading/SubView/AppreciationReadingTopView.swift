//
//  AppreciationReadingTopView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/4/25.
//

import SwiftUI

/// 감상 읽기 네비게이션 바 + 커스텀 메뉴(모달)
struct AppreciationReadingTopView: View {
    // MARK: - Properties
    var backButtonTapAction: () -> Void
    var ellipseButtonTapAction: () -> Void
    var editButtonTapAction: () -> Void
    var deleteButtonTapAction: () -> Void
    @Binding var showModal: Bool
    
    // MARK: - init
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
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            // 네비게이션 바
//            AppreciationReadingNavigationBar(
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
    AppreciationReadingTopView(backButtonTapAction: {}, ellipseButtonTapAction: {}, editButtonTapAction: {}, deleteButtonTapAction: {}, showModal: .constant(true))
}

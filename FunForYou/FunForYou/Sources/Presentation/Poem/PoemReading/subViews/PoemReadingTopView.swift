//
//  AppreciationReadingTopView.swift
//  FunForYou
//
//  Created by 석민솔 on 6/4/25.
//

import SwiftUI

/// 시  읽기 네비게이션 바 + 커스텀 메뉴(모달)
struct PoemReadingTopView: View {
    // MARK: - Properties
    var poem: Poem
    var ellipseButtonTapAction: () -> Void
    var editButtonTapAction: () -> Void
    var deleteButtonTapAction: () -> Void
    var backButtonTapAction: () -> Void
    @Binding var showModal: Bool

    // MARK: - init

    init(
        poem: Poem,
        ellipseButtonTapAction: @escaping () -> Void,
        editButtonTapAction: @escaping () -> Void,
        deleteButtonTapAction: @escaping () -> Void,
        backButtonTapAction: @escaping () -> Void,
        showModal: Binding<Bool>
    ) {
        self.poem = poem
        self.ellipseButtonTapAction = ellipseButtonTapAction
        self.editButtonTapAction = editButtonTapAction
        self.deleteButtonTapAction = deleteButtonTapAction
        self.backButtonTapAction = backButtonTapAction
        self._showModal = showModal
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            // 네비게이션 바
            PoemReadingNavigationBar(
                poem: poem,
                ellipseButtonTapAction: ellipseButtonTapAction,
                backButtonTapAction: backButtonTapAction
            )

            // 메뉴 모달
            TopMenuModal(
                showModal: $showModal,
                modalStyle: .defaultTop(
                    modify: {
                        editButtonTapAction()
                        showModal = false
                    },
                    delete: {
                        deleteButtonTapAction()
                    }
                )
            )
            .padding(.horizontal, 20)
        }
        .frame(height: 33, alignment: .top)
        .zIndex(100)
    }
}

#Preview {
    PoemReadingTopView(
        poem: samplePoem, // 실제 Poem 객체 넘기기
        ellipseButtonTapAction: {},
        editButtonTapAction: {},
        deleteButtonTapAction: {},
        backButtonTapAction: {},
        showModal: .constant(true)
    )
}

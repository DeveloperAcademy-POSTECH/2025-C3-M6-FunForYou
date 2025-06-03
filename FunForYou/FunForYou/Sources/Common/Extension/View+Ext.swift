//
//  View+Ext.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

/// View Extension
extension View {
    /// hideKeyboardOnTap - 키보드 외의 화면 터치하면 키보드 자동 내림 효과를 위해 사용
    func hideKeyboardOnTap(action: @escaping () -> Void = { }) -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil)
            action()
        }
    }
}

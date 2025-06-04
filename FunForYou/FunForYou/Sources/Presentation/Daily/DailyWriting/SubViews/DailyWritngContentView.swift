//
//  Untitled.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

struct DailyWritingContentView: View {
    @Binding var dailyTitle: String
    @Binding var dailyContent: String
    @Binding var isShowImagePicker: Bool
    @Binding var selectedImage: UIImage?

    var body: some View {
        ScrollView {
            VStack {
                TitleLayoutView()
                TitleTextEditorView(text: $dailyTitle)
                PhotoButtonView (
                    selectedImage: $selectedImage,
                    isShowImagePicker: $isShowImagePicker
                )
                ContentLayoutView()
                ContentTextEditorView(text: $dailyContent)
                Spacer()
            }
        }
        .hideKeyboardOnTap()
    }
}

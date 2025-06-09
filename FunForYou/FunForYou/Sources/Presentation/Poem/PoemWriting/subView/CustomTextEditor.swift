//
//  CustomTextEditor.swift
//  FunForYou
//
//  Created by Woody on 6/3/25.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    var alignment: TextAlignmentType
    let characterLimit: Int = 1000

    let placeholder = """
    자유 형식으로 시를 써요.

    쓰고 있는 시는
    [임시보관]하면 나중에 이어 쓸 수 있어요.

    시를 다 썼다면
    [시 끝맺기]를 하고 나의 시집에서 읽어요.
    끝맺은 시들도 언제든지 고칠 수 있어요.
    """

    var body: some View {
        TextEditor(text: $text)
            .font(Font(UIFont.ffyPage))
            .multilineTextAlignment(alignment.swiftUITextAlignment)
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .overlay(
                Group {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                            .font(Font(UIFont.ffyPage))
                            .multilineTextAlignment(alignment.swiftUITextAlignment)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: .top))
                            .allowsHitTesting(false)  // placeholder는 터치 이벤트 무시해서 편집 가능하게
                    }
                }
            )
            .frame(minHeight: 400)
            .padding(.horizontal, 30)
            .padding(.bottom, 5)
            .onChange(of: text) {
                if text.count > characterLimit {
                    text = String(text.prefix(characterLimit))
                }
            }
    }
}


extension UIFont {
    static var ffyPage: UIFont {
        UIFont(name: "KimjungchulMyungjo-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
}

//
//  CustomTextEditor.swift
//  FunForYou
//
//  Created by Woody on 6/3/25.
//

import SwiftUI
import UIKit

struct CustomTextEditor: UIViewRepresentable {
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

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.font = .ffyPage
        textView.textAlignment = alignment.nsTextAlignment
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = true

        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = .ffyPage
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.tag = 100

        textView.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -5)
        ])

        placeholderLabel.isHidden = !text.isEmpty

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        uiView.textAlignment = alignment.nsTextAlignment
        uiView.font = .ffyPage

        if let placeholderLabel = uiView.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor

        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            if textView.text.count > parent.characterLimit {
                textView.text = String(textView.text.prefix(parent.characterLimit))
                let end = textView.endOfDocument
                textView.selectedTextRange = textView.textRange(from: end, to: end)
            }
            parent.text = textView.text

            if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
                placeholderLabel.isHidden = !textView.text.isEmpty
            }
        }
    }
}



extension UIFont {
    static var ffyPage: UIFont {
        UIFont(name: "KimjungchulMyungjo-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
}

extension TextAlignmentType {
    var nsTextAlignment: NSTextAlignment {
        switch self {
        case .left: return .left
        case .center: return .center
        case .right: return .right
        }
    }
}

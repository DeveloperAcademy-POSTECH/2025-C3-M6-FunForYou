//
//  PoemWritingContentView.swift
//  FunForYou
//
//  Created by Woody on 6/6/25.
//

import SwiftUI

struct PoemWritingContentView: View {
    @ObservedObject var viewModel: PoemWritingViewModel
    @FocusState.Binding var isEditorFocused: Bool
    @Environment(\.modelContext) private var context

    var body: some View {
        ScrollView {
            PoemTitleField(viewModel: viewModel)
                .onChange(of: viewModel.state.poem.title) { _, _ in
                    viewModel.action(.updateCanSave)
                }
                .focused($isEditorFocused)

            SelectInspiration(viewModel: viewModel)

            TextAlignmentPicker(
                selectedAlignment: Binding(
                    get: { viewModel.state.poem.alignment },
                    set: { viewModel.action(.updateAlignment($0)) }
                )
            )

            Divider()
                .padding(.horizontal, 24)
                .padding(.bottom, 30)

            CustomTextEditor(
                text: Binding(
                    get: { viewModel.state.poem.content },
                    set: { viewModel.action(.updateContent($0)) }
                ),
                alignment: viewModel.state.poem.alignment
            )
            .frame(minHeight: 408)
            .padding(.horizontal, 54)
            .padding(.bottom, 5)
            .focused($isEditorFocused)
            .onChange(of: viewModel.state.poem.content) { _, _ in
                viewModel.action(.updateCanSave)
            }

            PrimaryButton(
                title: "시 끝맺기",
                style: viewModel.canSave ? .basic : .disable
            ) {
                viewModel.action(.saveOrUpdatePoem(context: context, isCompleted: true))
            }
        }
    }
}


//
//  PoemWritingContentView.swift
//  FunForYou
//
//  Created by Woody on 6/6/25.
//

import SwiftUI

struct PoemWritingContentView: View {
    @ObservedObject var viewModel: PoemWritingViewModel
    @Environment(\.modelContext) private var context

    var body: some View {
        VStack {
            TextField("시 제목", text: $viewModel.state.poem.title)
                .font(FFYFont.title)
                .lineLimit(1)
                .padding(.bottom,20)
                .padding(.horizontal, 24)
                .onChange(of: viewModel.state.poem.title) { _, newValue in
                    if newValue.count > 15 {
                        viewModel.state.poem.title = String(newValue.prefix(15))
                    }
                }
                .onChange(of: viewModel.state.poem.title) { _, _ in
                    viewModel.action(.updateCanSave)
                }
                

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
            .frame(minHeight: 400)
            .padding(.horizontal, 30)
            .padding(.bottom, 5)
                        .onChange(of: viewModel.state.poem.content) { _, _ in
                viewModel.action(.updateCanSave)
            }

            PrimaryButton(
                title: "시 끝맺기",
                style: viewModel.canSave ? .basic : .disable
            ) {
                viewModel.action(
                    .saveOrUpdatePoem(context: context, isCompleted: true)
                )
            }
            Spacer()
        }
        .hideKeyboardOnTap()
    }
}

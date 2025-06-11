//
//  InspirationNoteTopView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//
import SwiftUI

struct InspirationNoteTopView: View {
    var writeDailyButtonTapAction: () -> Void
    var writeAppreciationButtonTapAction: () -> Void
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            // 뷰 제목
            Text("시상 수첩")
                .font(FFYFont.largeTitle)
                .foregroundStyle(FFYColor.black)
            
            Spacer()
            
            // 메뉴 버튼
            Menu {
                // 일상 이야기예요
                Button {
                    writeDailyButtonTapAction()
                } label: {
                    Text("일상 이야기예요")
                }
                
                // 감상한 콘텐츠가 있어요
                Button {
                    writeAppreciationButtonTapAction()
                } label: {
                    Text("감상한 콘텐츠가 있어요")
                }
            } label: {
                Text("시상 쓰기")
                    .foregroundStyle(FFYColor.pinkDark)
                    .font(FFYFont.title3)
            }
        }
    }
}


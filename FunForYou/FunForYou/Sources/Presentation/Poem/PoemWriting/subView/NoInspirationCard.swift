//
//  NoInspirationCard.swift
//  FunForYou
//
//  Created by Woody on 6/6/25.
//

import SwiftUI

struct NoInspirationCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("고르지 않고 자유시 쓰기")
                    .font(FFYFont.title3)
                    .foregroundStyle(FFYColor.black)
                    .lineLimit(1)

                Spacer()

                Image(systemName: "burst.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(FFYColor.pinkDark)
            }
            .padding(.bottom, 10)

            Text("수첩에 써 둔 시상을 고르지 않고\n떠오른 생각이나 감정으로 자유롭게 써요")
                .font(FFYFont.subHeadline)
                .foregroundStyle(FFYColor.gray3)
                .lineLimit(2)

            Spacer()
           
        }
        .frame(height: 90)
        .padding(25)
    }
}


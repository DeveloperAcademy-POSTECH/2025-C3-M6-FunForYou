//
//  InspirationPreviewList.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import SwiftUI

struct InspirationPreviewList: View {
    var inspirations: [any Inspiration]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(inspirations, id: \.id) { inspiration in
                    if let daily = inspiration as? Daily {
                        InspirationPreviewCard(inspiration: daily)
                    }
                    else if let appreciation = inspiration as? Appreciation {
                        InspirationPreviewCard(inspiration: appreciation)
                    }
                    Rectangle()
                        .fill(FFYColor.gray1)
                        .frame(
                            width: UIScreen.main.bounds.width - 48,
                            height: 1
                        )
                }
            }
        }
    }
}

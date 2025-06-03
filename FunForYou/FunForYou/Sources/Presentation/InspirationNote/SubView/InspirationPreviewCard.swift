//
//  InspirationPreviewCard.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import SwiftUI

struct InspirationPreviewCard<T: Inspiration>: View {
    var inspiration: T
    
    init(inspiration: T) {
        self.inspiration = inspiration
    }
    
    var body: some View {
        Group {
            if let daily = inspiration as? Daily {
                DailyPreviewContentView(daily: daily)
            }
            else if let appreciation = inspiration as? Appreciation {
                AppreciationPreviewContentView(appreciation: appreciation)
            }
        }
    }
}

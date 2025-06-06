//
//  DailyPreviewContentView.swift
//  FunForYou
//
//  Created by 한건희 on 6/3/25.
//

import SwiftUI

struct DailyPreviewContentView: View {
    var image: UIImage?
    var daily: Daily
    
    init(daily: Daily) {
        self.daily = daily
        image = ImageManager.shared.loadImage(withName: daily.image ?? "")
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 140)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                    .padding(.trailing, 11)
            }
            
            DailyTextContentView(image: image, daily: daily)
        }
        .frame(height: image != nil ? 150 : 110)
        .padding(.all, 25)
    }
}

//
//  PhotoButtonView.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

struct PhotoButtonView: View {
    @Binding var selectedImage: UIImage?
    @Binding var isShowImagePicker: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Text("사진")
                .font(FFYFont.title3)
                .foregroundColor(FFYColor.gray3)
                .padding(.trailing, 15)
            
            Button(action: {
                if selectedImage == nil {
                    isShowImagePicker = true
                } else {
                    selectedImage = nil
                }
            }, label: {
                HStack {
                    Text(selectedImage == nil ? "사진 넣기" : "사진 빼기")
                        .font(FFYFont.body)
                        .foregroundColor(FFYColor.black)
                        .padding(.leading, 10)
                        .padding(.vertical, 4)
                    
                    Image(systemName: selectedImage == nil ? "plus.circle.fill" : "minus.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(selectedImage == nil ? FFYColor.pinkDark : FFYColor.gray1, FFYColor.gray0)
                        .padding(.trailing, 8)
                }
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(selectedImage == nil ? FFYColor.pinkLight : FFYColor.gray1)
                )
            })
            Spacer()
        }
        .padding(.top, 26)
        .padding(.horizontal, 24)
        
        if let image = selectedImage {
            Image(uiImage: image)
                .resizable()
                .frame(height: 240)
                .clipped()
                .cornerRadius(20)
                .padding(.horizontal, 24)
                .allowsHitTesting(false)
        }
    }
}

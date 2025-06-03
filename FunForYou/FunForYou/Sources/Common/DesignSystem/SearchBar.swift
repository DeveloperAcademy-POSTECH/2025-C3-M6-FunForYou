//
//  SearchBar.swift
//  FunForYou
//
//  Created by 배현진 on 6/3/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(FFYColor.gray3)
            
            TextField("검색하기", text: $text)
                .foregroundColor(FFYColor.black)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(12)
        .background(FFYColor.gray3.opacity(0.12))
        .cornerRadius(10)
        .padding(.horizontal, 24)
    }
}

#Preview {
    @Previewable @State var searchText = ""
    SearchBar(text: $searchText)
}

//
//  PoemType.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

enum PoemType: Codable {
    case none
    case daily(String) // 일상
    case appreciation(String) // 감상
}

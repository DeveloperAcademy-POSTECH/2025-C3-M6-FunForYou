//
//  PoemType.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

enum PoemType: Codable {
    case none
    /// 일상 시
    /// - 연관 값 : 시의 ID
    case daily(String) // 일상
    /// 일상 시
    /// - 연관 값 : 시의 ID
    case appreciation(String) // 감상
    
    var id: String? {
        switch self {
        case .none:
            return nil
        case .daily(let id):
            return id
        case .appreciation(let id):
            return id
        }
    }
}

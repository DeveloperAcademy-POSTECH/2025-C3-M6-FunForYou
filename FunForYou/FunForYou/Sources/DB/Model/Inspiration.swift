//
//  Inspiration.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import Foundation
import SwiftData

/// 시상의 공통 속성을 정의하는 프로토콜입니다.
protocol Inspiration: PersistentModel {
    var id: String { get set }
    var title: String? { get set }
    var content: String? { get set }
    var date: Date { get set }
}

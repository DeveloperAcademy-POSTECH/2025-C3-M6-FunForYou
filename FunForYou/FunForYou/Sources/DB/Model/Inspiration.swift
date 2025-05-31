//
//  Inspiration.swift
//  FunForYou
//
//  Created by 한건희 on 5/31/25.
//

import Foundation
import SwiftData

protocol Inspiration: PersistentModel {
    var id: String { get set }
    var title: String { get set }
    var content: String { get set }
    var date: Date { get set }
}

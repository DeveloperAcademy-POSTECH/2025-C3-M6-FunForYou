//
//  Coordinator.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import SwiftUI
import Combine
import Foundation

final class Coordinator: ObservableObject {
    @Published var path: [Path] = []
    
    func push(_ path: Path) {
        self.path.append(path)
    }
    
    func popLast() {
        _ = self.path.popLast()
    }
    
    func removeAll() {
        self.path.removeAll()
    }
}

enum Path: Hashable {
    case inspirationNote
    case completeCollection
    case ongoingCollection
    case dailyWriting(Daily?)
    case dailyReading(Daily)
    case appreciationWriting(Appreciation?)
    case appreciationReading(Appreciation)
    case poemWriting(Poem?)
    case poemReading(Poem)
}

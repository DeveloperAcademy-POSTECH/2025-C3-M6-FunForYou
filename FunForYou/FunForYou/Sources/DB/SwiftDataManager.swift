//
//  SwiftDataManager.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import Foundation
import SwiftData
import SwiftUI

final class SwiftDataManager {
    static var shared: SwiftDataManager = SwiftDataManager()
    
    private init() { }
    
    
    func savePoem(poem: Poem, context: ModelContext) {
        context.insert(poem)
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func fetchAllPoemList(context: ModelContext) -> [Poem] {
        let fetchDescriptor = FetchDescriptor<Poem>(sortBy: [SortDescriptor(\.date, order: .forward)])
        
        do {
            let poemList = try context.fetch(fetchDescriptor)
            return poemList
        } catch {
            return []
        }
    }
}

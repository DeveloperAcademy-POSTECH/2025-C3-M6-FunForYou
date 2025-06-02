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
    
    // MARK: - Poem CRUD
    
    /// 시 저장 (Create)
    func savePoem(
        poem: Poem,
        context: ModelContext
    ) -> Result<Void?, Error> {
        return save(value: poem, context: context)
    }
    
    /// 모든 시 불러오기 (Read)
    func fetchAllPoemList(context: ModelContext) -> Result<[Poem], Error> {
        let fetchDescriptor = FetchDescriptor<Poem>()
        
        do {
            let poemList = try context.fetch(fetchDescriptor)
            return .success(poemList)
        } catch {
            return .failure(error)
        }
    }
    
    /// id로 시 불러오기 (Read)
    func fetchPoemFromId(
        poemId: String,
        context: ModelContext
    ) -> Result<Poem?, Error> {
        let predicate = #Predicate<Poem> { $0.id == poemId }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        
        do {
            let poems = try context.fetch(fetchDescriptor)
            return .success(poems.first)
        } catch {
            return .failure(error)
        }
    }
    
    /// inspiration 타입 시상으로 작성된 시를 불러오기
    func fetchAllPoemFromInspirationType<T: Inspiration>(
        inspirationType: T.Type,
        context: ModelContext
    ) -> Result<[Poem], Error> {
        let predicate = #Predicate<Poem> { $0.type.typeDescription == inspirationType.typeDescription }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        do {
            let poemList = try context.fetch(fetchDescriptor)
            return .success(poemList)
        } catch {
            return .failure(error)
        }
    }
    
    /// 시 수정 (Update)
    func updatePoem(context: ModelContext) -> Result<Void?, Error> {
        return update(context: context)
    }

    /// 시 삭제 (Delete)
    func deletePoem(
        poem: Poem,
        context: ModelContext
    ) -> Result<Void?, Error> {
        return delete(value: poem, context: context)
    }

    
    // MARK: - Inspiration CRUD
    
    /// 시상(Appreciation, Daily) 정보 저장 (Create)
    func saveInspiration<T: Inspiration>(
        inspiration: T,
        context: ModelContext
    ) -> Result<Void?, Error> {
        return save(value: inspiration, context: context)
    }
    
    /// 시상(Appreciation, Daily) 정보 모두 가져오기 (Read)
    func fetchAllInspiration<T: Inspiration>(
        InspirationType: T.Type,
        context: ModelContext
    ) -> Result<[T], Error> {
        let fetchDescriptor = FetchDescriptor<T>()
        
        do {
            let inspirations = try context.fetch(fetchDescriptor)
            return .success(inspirations)
        } catch {
            return .failure(error)
        }
    }
    
    /// 시상(Appreciation, Daily) 정보 id로 가져오기 (Read)
    func fetchInspirationById<T: Inspiration>(
        inspirationType: T.Type,
        inspirationId: String,
        context: ModelContext
    ) -> Result<T?, Error> {
        let predicate = #Predicate<T> { $0.id == inspirationId }
        let fetchDescriptor = FetchDescriptor<T>(predicate: predicate)
        do {
            let inspiration = try context.fetch(fetchDescriptor)
            return .success(inspiration.first)
        } catch {
            return .failure(error)
        }
    }
    
    /// 시상 수정 (Update)
    func updateInspiration(context: ModelContext) -> Result<Void?, Error> {
        return update(context: context)
    }

    /// 시상 삭제 (Delete)
    func deleteInspiration<T: Inspiration>(
        inspiration: T,
        context: ModelContext
    ) -> Result<Void?, Error> {
        return delete(value: inspiration, context: context)
    }
    
    // MARK: - Create, Update, Delete function
    
    /// 시, 시상에 대한 저장 관련 중복되는 부분을 구현한 메서드입니다.
    func save<T: PersistentModel>(
        value: T,
        context: ModelContext
    ) -> Result<Void?, Error> {
        context.insert(value)
        do {
            try context.save()
        } catch {
            return .failure(error)
        }
        return .success(nil)
    }
    
    /// 시, 시상에 대한 업데이트 관련 중복되는 부분을 구현한 메서드입니다.
    func update(context: ModelContext) -> Result<Void?, Error> {
        do {
            try context.save() // context 내에서 이미 수정되었다면 저장만 하면 됨 (뷰에서 model.title = "바뀐 타이틀")
        } catch {
            return .failure(error)
        }
        return .success(nil)
    }
    
    /// 시, 시상에 대한 삭제 관련 중복되는 부분을 구현한 메서드입니다.
    func delete<T: PersistentModel>(
        value: T,
        context: ModelContext
    ) -> Result<Void?, Error> {
        context.delete(value)
        do {
            try context.save()
        } catch {
            return .failure(error)
        }
        return .success(nil)
    }
}

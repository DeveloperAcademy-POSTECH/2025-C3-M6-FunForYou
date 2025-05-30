//
//  ViewModelable.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//
import Combine

protocol ViewModelable: ObservableObject {
    associatedtype Action
    associatedtype State
    
    /// State는 뷰의 상태를 정의하는 구조체입니다. 필수로 구현해주어야 합니다.
    var state: State { get }
    
    /// 각 ViewModel에서 Action을 정의해야 하며, 뷰에서 특정 로직을 타거나, 상태 변경이 필요할 경우 해당 action 메서드를 호출합니다.
    func action(_ action: Action)
}

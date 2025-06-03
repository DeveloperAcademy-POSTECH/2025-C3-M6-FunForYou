//
//  AlertStyleType.swift
//  FunForYou
//
//  Created by 배현진 on 6/2/25.
//

enum AlertStyleType {
    case basic
    case deleteInspiration
    case deletePoem
    
    var title: String {
        switch self {
        case .basic:
            return "이전 화면으로 돌아갈까요?"
        case .deleteInspiration:
            return "읽고 있던 시상을 지울까요?"
        case .deletePoem:
            return "읽고 있던 시를 지울까요?"
        }
    }
    
    var content: String {
        switch self {
        case .basic:
            return "쓰던 내용은 모두 사라져요."
        case .deleteInspiration:
            return "한 번 지운 시상은 다시 찾을 수 없어요."
        case .deletePoem:
            return "한 번 지운 시는 다시 찾을 수 없어요."
        }
    }
    
    var primaryTitle: String {
        switch self {
        case .basic:
            return "아니요, 계속 쓸래요"
        case .deleteInspiration:
            return "아니요, 계속 볼래요"
        case .deletePoem:
            return "아니요, 계속 볼래요"
        }
    }
    
    var secondaryTitle: String {
        switch self {
        case .basic:
            return "네, 이전으로 돌아갈게요"
        case .deleteInspiration:
            return "네, 수첩에서 지울게요"
        case .deletePoem:
            return "네, 시집에서 지울게요"
        }
    }
}

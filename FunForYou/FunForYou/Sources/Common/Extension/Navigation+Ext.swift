//
//  Navigation+Ext.swift
//  FunForYou
//
//  Created by 배현진 on 6/12/25.
//

import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
        // TODO: - 필요 시점에 뷰 스택 2개 이상인 경우에만 사용 가능하도록 설정 (Berry)
        // 현재는 네비게이션 구조가 잘 적용되어 있고, 예외의 경우가 없어서 뷰 스택이 1개인 경우에도 문제없이 뒤로가기 수행된다.
    }
}

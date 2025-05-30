//
//  TestView.swift
//  FunForYou
//
//  Created by 한건희 on 5/30/25.
//

import SwiftUI
import Combine
import SwiftData

struct TestMainView: View {

    @StateObject var viewModel: TestMainViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: TestMainViewModel(coordinator: coordinator))
    }
    
    // MARK: SwiftData - modelContext 불러오는 부분입니다. SwiftData 모델 데이터가 필요한 각 뷰에서 @Environment 프로퍼티 래퍼로 가져와 선언해주세요!
    @Environment(\.modelContext) var context
    var body: some View {
        VStack {
            // MARK: 예제로 ViewModel의 Poem 모델 데이터 title만 수정하기 위함
            TextField("title", text: $viewModel.state.newPoem.title)
                .background(RoundedRectangle(cornerRadius: 20).fill(.gray))
                .frame(width: 200)
            
//            MARK: save 버튼 탭 시 action 을 호출하여 ViewModel에서 모델을 저장하도록 구현되어 있습니다. context를 연관 값으로 넘겨주어 SwiftDataManager가 modelContext에 접근할 수 있도록 합니다.
            Button(action: {
                viewModel.action(.save(context))
            }, label: {
                Text("save")
            })
            
            // MARK: ViewModel에서 state로 가지고 있는 poemList를 뷰에 title만 보여줍니다.
            ForEach(Array(zip(viewModel.state.poemList.indices, viewModel.state.poemList)), id: \.0) { index, poem in
                Text("poemIndex: \(index), poemTitle: \(poem.title)")
            }
            
            // MARK: 뷰 네비게이팅 테스트 코드입니다.
            Button(action: {
                viewModel.action(.testAppendView)
            }) {
                Text("뷰 네비게이팅 테스트")
            }
        }
        .onAppear {
            viewModel.action(.viewAppeared(context))
        }
    }
}

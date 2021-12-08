//
//  SampleViewModel.swift
//  MVVM_Sample
//
//  Created by InJe Choi on 2021/12/06.
//

// Timer를 사용하기 위해 import
import Foundation

class SampleViewModel {
    
    // View Model은 Model을 갖고 있다.
    var model: SampleModel?
    
    init() {
        self.model = SampleModel()
    }
    
    func changeLabel(_ tf: String) {
        // ViewModel은 Model을 update할 수 있다
        // View Component와 binding 처리 돼있으므로 최신화가 된다
        model?.head.value = tf
    }
    
    // 야매 비즈니스 로직
    func changeModel() {
        // 2초 뒤에 Model 안에 값 변경
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(checkModel), userInfo: nil, repeats: false)
    }
    
    @objc func checkModel() {
        // model 값 변경
        model?.head.value = "change"
    }
}

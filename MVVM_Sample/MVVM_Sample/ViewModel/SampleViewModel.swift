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
    var model = SampleModel(head: "init")
    let obs = Observer("")
    
    func changeLabel(_ tf: String) {
        // ViewModel은 Model을 update할 수 있다
        // View Component와 binding 처리 돼있으므로 최신화가 된다
        model.head = tf
        obs.value = model.head
    }
    
    func fetch() {
        // model.head = restGet()
        obs.value = model.head
    }

}


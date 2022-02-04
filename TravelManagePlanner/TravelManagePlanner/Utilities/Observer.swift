//
//  Observer.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/08.
//

import Foundation

final class Observable<T> {
    
    
    // Listener: 값이 변경될 때 마다 호출되며, 변경된 값을 리턴해주는 클로저
    typealias Listener = (T) -> Void
    // listener: value의 변화를 관찰하고 있는 대상
    var listener: Listener?

    /*
     didSet = Property Observer
     property 값의 변경 직후를 감지
     didSet이 변화를 감지하여 listener를 호출
     Property Observer는 해당 property 값을 변경하는 주체가 누구든지, 어디서 변경 됐는지 신경쓰지 않고
     해당 프로퍼티의 값이 변경되기만 하면 실행된다.
     */
    var value: T {
        didSet {
            // "listener(observing하는 중인 객체)야 지금 값은 value다"라고 알려줌
            // binding된 상태라면 View Component에 변화가 생김
            listener?(value)
            print("새로운 값: \(self.value), 예전 값: \(oldValue)")
        }
    }
    
    // didSet: property observer를 사용하기 위해선 초기값이 무조건 필요
    init(_ value: T) {
        self.value = value
    }
    // bind는 View Component가 value를 Observing하게 만드는 메소드
    func bind(listener: Listener?) {
        self.listener = listener
        // 현재 값을 리턴
        listener?(value)
    }
}

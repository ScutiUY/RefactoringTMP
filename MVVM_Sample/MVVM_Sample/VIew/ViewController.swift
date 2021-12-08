//
//  ViewController.swift
//  MVVM_Sample
//
//  Created by InJe Choi on 2021/12/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var headLabel: UILabel!
    @IBOutlet var headTextField: UITextField!
    @IBOutlet var button: UIButton!
    
    // MVVM에서 View는 View Model을 갖고 있다.
    private let viewModel = SampleViewModel()
    
    // 뷰가 메모리에 올라가면
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Component와 ViewModel의 프로퍼티 binding -> Observing 시작
        /*
         ViewModel은 Model을 가지고 있으므로
         ViewModel 객체 내에 있는 Model 객체 중 observable property에 접근하여
         해당 property에 변화가 생기면 View Component가 update되도록 처리
         (View가 Model에 직접 접근하는 것이 아니다)
         */
        viewModel.model?.head.bind { [weak self] modelHead in
            self?.headLabel.text = modelHead
        }
    }
    
    // 버튼을 누르면 텍스트 필드 안에 값을 읽어와서 ViewModel 로직 수행
    @IBAction func changeModelButton(_ sender: UIButton) {
        let tf = headTextField.text!
        headTextField.text = ""
        
        // ViewModel 메소드 호출
        // ViewModel에 변화가 생겼다? -> View 바뀜
        viewModel.changeLabel(tf)
        
        // 모델에 비즈니스 로직으로 인한 변화가 생겼을 때 대응되는지 확인해 보기 위한 메소드
        viewModel.changeModel()
    }

}

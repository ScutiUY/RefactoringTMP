//
//  ViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import UIKit
import SnapKit

class SampleViewController: UIViewController {

    let abutton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(abutton)
        view.backgroundColor = .white
        
        abutton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        abutton.backgroundColor = .blue
        abutton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    @objc func buttonAction() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondSampleViewController") as! SecondSampleViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}


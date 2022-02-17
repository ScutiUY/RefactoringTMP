//
//  ResignViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/15.
//

import UIKit

class ResignViewController: UIViewController {

    var viewModel = ResignViewModel()
    
    lazy var checkLabel: UILabel = {
        var label = UILabel()
        label.text = "Are you sure resign?".localized
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = GlobalConstants.Color.Text.invalidateTextColor
        return label
    }()
    
    lazy var resignButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Confirm".localized, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.signUpLabelFontSize)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = GlobalConstants.Color.Background.loginButtonbackgroundColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setObserver()
        // Do any additional setup after loading the view.
    }
    
    func setLayout() {
        self.view.backgroundColor = GlobalConstants.Color.Background.themeColor
        view.addSubview(checkLabel)
        view.addSubview(resignButton)
        
        checkLabel.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            m.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        resignButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }

    func setObserver() {
        
        resignButton.addTarget(self, action: #selector(resign), for: .touchUpInside)

        viewModel.resignCompleted.bind { [weak self] in
            if $0 {
                // alert 해준 후 pop 해줄 예정
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func resign() {
        viewModel.resign()
    }
    
}

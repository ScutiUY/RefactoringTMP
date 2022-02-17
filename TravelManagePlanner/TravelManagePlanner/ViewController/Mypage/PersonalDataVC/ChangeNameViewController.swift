//
//  ChangeNameViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/14.
//

import UIKit
import SnapKit

class ChangeNameViewController: UIViewController {

    var viewModel = ChangeNameViewModel()
    
    lazy var nickNameTextField: UITextField = {
        var textField = UITextField()
        textField.text = UserData.shared.nickname
        textField.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.signUpLabelFontSize)
        textField.backgroundColor = .gray
        textField.textColor = .black
        return textField
    }()
    
    lazy var confirmButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("confirm", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.signUpLabelFontSize)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = GlobalConstants.Color.Background.loginButtonbackgroundColor
        return button
    }()
    
    private var invalidLabel: UILabel = {
        var label = UILabel()
        label.text = "이름을 정확히 입력해 주십시오."
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = GlobalConstants.Color.Text.invalidateTextColor
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObserver()
        setLayout()
    }
    
    func setObserver() {
        
        confirmButton.addTarget(self, action: #selector(confirmChangeName), for: .touchUpInside)
        
        viewModel.userInfoInputErrorMessage.bind { [weak self] in
            self?.invalidLabel.text = $0
            print($0)
        }
        
        viewModel.updateCompleted.bind { [weak self] in
            if $0 {
                // alert 해준 후 pop 해줄 예정
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setLayout() {
        
        view.backgroundColor = GlobalConstants.Color.Background.themeColor
        view.addSubview(nickNameTextField)
        view.addSubview(confirmButton)
        view.addSubview(invalidLabel)
        
        nickNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        invalidLabel.snp.makeConstraints { (m) in
            m.centerY.equalTo(nickNameTextField.snp.centerY)
            m.leading.equalTo(nickNameTextField.snp.leading)
        }
        
    }
    
    @objc func confirmChangeName() {
        guard let ChangedName = nickNameTextField.text else { return }
        viewModel.updateUserName(name: ChangedName)
        
        if viewModel.validateName() == .success {
            viewModel.register()
        } else {
            UIView.animate(withDuration: 0.2) {
                self.invalidLabel.snp.remakeConstraints({ (m) in
                    m.top.equalTo(self.nickNameTextField.snp.bottom).offset(5)
                    m.leading.equalTo(self.nickNameTextField.snp.leading)
                })
                self.view.layoutIfNeeded()
            }
        }
        
    }
}

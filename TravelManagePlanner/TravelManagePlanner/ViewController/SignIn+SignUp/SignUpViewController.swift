//
//  SignUpViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/02.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    private var containerView = UIView()
    private lazy var exitButton:UIButton = {
        var button = UIButton(type: .system)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("✖︎", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var emailLabel: UILabel = {
        var label = UILabel()
        label.text = "Email"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    private lazy var pwLabel: UILabel = {
        var label = UILabel()
        label.text = "Password"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Name(선택)"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    private lazy var emailTextField : UITextField = {
        var textField = UITextField()
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        
        return textField
    }()
    private lazy var pwTextField : UITextField = {
        var textField = UITextField()
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    private lazy var nameTextField : UITextField = {
        var textField = UITextField()
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var registerButton : UIButton = {
        var button = UIButton.init(type: .system)
        button.setTitle("register", for: .normal)
        button.setTitleColor(GlobalConstants.Color.Text.buttonTextColor, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()
    
    private var cottonView : UIView = {
        var view = UIView()
        view.backgroundColor = GlobalConstants.Color.Background.themeColor
        return view
    }()
    private var invalidLabel: UILabel = {
        var label = UILabel()
        label.text = "이메일을 정확히 입력해 주십시오."
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = GlobalConstants.Color.Text.invalidateTextColor
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        emailTextField.delegate = self
        pwTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTextFieldUnderLine()
    }
    private func setLayout() {
        
        view.backgroundColor = UIColor(red: 131/255, green: 247/255, blue: 178/255, alpha: 1)
        view.addSubview(containerView)
        view.addSubview(exitButton)
        containerView.addSubview(emailLabel)
        containerView.addSubview(pwLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(pwTextField)
        containerView.addSubview(nameTextField)
        containerView.addSubview(registerButton)
        containerView.addSubview(cottonView)
        containerView.sendSubviewToBack(cottonView)
        containerView.addSubview(invalidLabel)
        containerView.sendSubviewToBack(invalidLabel)
        
        containerView.snp.makeConstraints { (m) in
            m.centerX.equalTo(view.snp.centerX)
            m.centerY.equalTo(view.snp.centerY).multipliedBy(0.8)
            m.width.equalTo(view.snp.width).multipliedBy(0.8)
            m.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        emailLabel.snp.makeConstraints { (m) in
            m.leading.equalTo(emailTextField.snp.leading)
            m.bottom.equalTo(emailTextField.snp.top).offset(-5)
        }
        
        emailTextField.snp.makeConstraints { (m) in
            m.centerX.equalTo(containerView.snp.centerX)
            m.bottom.equalTo(pwLabel.snp.top).offset(-10)
            m.width.equalTo(containerView.snp.width).multipliedBy(0.85)
            m.height.equalTo(30)
        }
        
        pwLabel.snp.makeConstraints { (m) in
            m.leading.equalTo(pwTextField.snp.leading)
            m.bottom.equalTo(pwTextField.snp.top).offset(-5)
        }
        pwTextField.snp.makeConstraints { (m) in
            m.centerX.equalTo(containerView.snp.centerX)
            m.centerY.equalTo(containerView.snp.centerY)
            m.width.equalTo(containerView.snp.width).multipliedBy(0.85)
            m.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { (m) in
            m.leading.equalTo(nameTextField.snp.leading)
            m.top.equalTo(pwTextField.snp.bottom).offset(5)
        }
        nameTextField.snp.makeConstraints { (m) in
            m.centerX.equalTo(containerView.snp.centerX)
            m.top.equalTo(nameLabel.snp.bottom).offset(5)
            m.width.equalTo(containerView.snp.width).multipliedBy(0.85)
            m.height.equalTo(30)
        }
        
        registerButton.snp.makeConstraints { (m) in
            m.centerX.equalTo(containerView.snp.centerX)
            m.bottom.equalTo(containerView.snp.bottom).offset(-10)
            m.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
        exitButton.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            m.leading.equalTo(view.snp.leading).offset(10)
            m.width.equalTo(40)
            m.height.equalTo(40)
        }
        
        cottonView.snp.makeConstraints { (m) in
            m.centerX.equalTo(containerView.snp.centerX)
            m.top.equalTo(nameLabel.snp.bottom).offset(5)
            m.width.equalTo(containerView.snp.width).multipliedBy(0.85)
            m.height.equalTo(30)
        }
        
        invalidLabel.snp.makeConstraints { (m) in
            m.centerY.equalTo(nameTextField.snp.centerY)
            m.leading.equalTo(nameTextField.snp.leading)
        }
    }
    
    private func setTextFieldUnderLine() {
        
        let border1: CALayer? = CALayer()
        let border2: CALayer? = CALayer()
        let border3: CALayer? = CALayer()
        if let border1 = border1 {
            border1.frame = CGRect(x: 0, y: emailTextField.frame.size.height-1, width: emailTextField.frame.width, height: 1)
            border1.backgroundColor = UIColor.black.cgColor
            emailTextField.layer.addSublayer(border1)
        }
        if let border2 = border2 {
            border2.frame = CGRect(x: 0, y: emailTextField.frame.size.height-1, width: emailTextField.frame.width, height: 1)
            border2.backgroundColor = UIColor.black.cgColor
            pwTextField.layer.addSublayer(border2)
        }
        if let border3 = border3 {
            border3.frame = CGRect(x: 0, y: emailTextField.frame.size.height-1, width: emailTextField.frame.width, height: 1)
            border3.backgroundColor = UIColor.black.cgColor
            nameTextField.layer.addSublayer(border3)
        }
        
        emailTextField.textAlignment = .left
        emailTextField.textColor = UIColor.black
        
        
        pwTextField.textAlignment = .left
        pwTextField.textColor = UIColor.black
        
        
        nameTextField.textAlignment = .left
        nameTextField.textColor = UIColor.black
        
    }
    
    // MARK: -  Button Action
    
    @objc func exitButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    @objc func registerAction() {
        
        guard let email = emailTextField.text else { return }
        guard let password = pwTextField.text else { return }
        
        let regex = try? NSRegularExpression.init(pattern: "[A-Z0-9a-z._&+-]+@[A-Z0-9a-z.-]+[.]+[A-Za-z]{2,20}")
        let textToNS = email as NSString
        let emailCheck = regex?.matches(in: email, options: [], range: NSRange(location: 0, length: textToNS.length)).map{textToNS.substring(with: $0.range)}
        
        if emailCheck!.isEmpty || email == "" {
            self.invalidLabel.text = "이메일을 정확하게 입력하세요."
            UIView.animate(withDuration: 0.2) {
                self.invalidLabel.snp.remakeConstraints({ (m) in
                    m.top.equalTo(self.nameTextField.snp.bottom).offset(5)
                    m.leading.equalTo(self.nameTextField.snp.leading)
                })
                self.view.layoutIfNeeded()
            }
            return
        } else if password == "" || password.count < 6 {
            self.invalidLabel.text = "비밀번호를 6자리 이상 입력해 주세요."
            UIView.animate(withDuration: 0.2) {
                self.invalidLabel.snp.remakeConstraints({ (m) in
                    m.top.equalTo(self.nameTextField.snp.bottom).offset(5)
                    m.leading.equalTo(self.nameTextField.snp.leading)
                })
                self.view.layoutIfNeeded()
            }
        } else {
            print("계정 생성")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
        self.pwTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
    }
    
}


extension SignUpViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.pwTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.invalidLabel.snp.remakeConstraints({ (m) in
                m.centerY.equalTo(self.nameTextField.snp.centerY)
                m.leading.equalTo(self.nameTextField.snp.leading)
            })
            self.view.layoutIfNeeded()
        }
    }
}


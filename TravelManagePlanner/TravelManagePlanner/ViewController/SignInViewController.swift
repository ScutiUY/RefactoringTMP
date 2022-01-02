//
//  SignInViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/02.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    var isLoading = false
    
    /// - Logo Image Section
    
    lazy var totalPaddingView: UIView = {
        var view = UIView()
        return view
    }()
    
    lazy var logoImageAnchorView: UIView = {
        var view = UIView()
        return view
    }()
    lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    lazy var loginInfoSectionStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .equalCentering
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "email을 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.mainFontSize)
        textField.borderStyle = .roundedRect
        return textField
    }()
    lazy var pwdTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.mainFontSize)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var invalidLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "비밀번호 오류"
        label.textColor = .red
        return label
    }()
    
    lazy var loginButton: LoadingButton = {
        var button = LoadingButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(GlobalConstants.Color.Text.buttonTextColor, for: .normal)
        button.backgroundColor = GlobalConstants.Color.Background.loginButtonbackgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.mainFontSize)
        return button
    }()
    
    lazy var socialLoginButtonAnchorView: UIView = {
        var view = UIView()
        return view
    }()
    lazy var socialLoginButtonStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.backgroundColor = .gray
        return stackView
    }()
    
    lazy var buttonAnchorView: UIView = {
        var view = UIView()
        return view
    }()
    
    lazy var signUpLabel: UILabel = {
        var label = UILabel()
        label.text = "회원이 아니신가요?"
        return label
    }()
    lazy var signUpButton: UIButton = {
        var button = UIButton()
        button.setTitle("새 계정 만들기", for: .normal)
        button.setTitleColor(GlobalConstants.Color.Text.buttonTextColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    lazy var findPwdButton: UIButton = {
        var button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(GlobalConstants.Color.Text.buttonTextColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setLayout()
        setButtonAction()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Layout setting
    func setLayout() {
        
        view.backgroundColor = GlobalConstants.Color.Background.themeColor
        
        view.addSubview(totalPaddingView)
        totalPaddingView.addSubview(logoImageAnchorView)
        logoImageAnchorView.addSubview(logoImageView)
        
        totalPaddingView.addSubview(loginInfoSectionStackView)
        
        loginInfoSectionStackView.addArrangedSubview(emailTextField)
        loginInfoSectionStackView.addArrangedSubview(pwdTextField)
        
        totalPaddingView.addSubview(invalidLabel)
        
        totalPaddingView.addSubview(loginButton)
        
        totalPaddingView.addSubview(findPwdButton)
        
        totalPaddingView.addSubview(socialLoginButtonAnchorView)
        socialLoginButtonAnchorView.addSubview(socialLoginButtonStackView)
        
        totalPaddingView.addSubview(signUpLabel)
        totalPaddingView.addSubview(signUpButton)
        
        totalPaddingView.snp.makeConstraints { const in
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            const.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            const.centerX.equalToSuperview()
            const.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
        
        logoImageAnchorView.snp.makeConstraints { const in
            const.top.equalToSuperview()
            const.bottom.equalTo(totalPaddingView.snp.centerY).multipliedBy(0.75)
            const.width.equalTo(totalPaddingView.snp.width)
            const.centerX.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { const in
            const.centerX.equalToSuperview()
            const.centerY.equalToSuperview()
            const.height.equalToSuperview().multipliedBy(0.8)
            const.width.equalTo(logoImageView.snp.height)
        }
        loginInfoSectionStackView.snp.makeConstraints { const in
            const.top.equalTo(logoImageAnchorView.snp.bottom).offset(10)
            const.width.equalTo(totalPaddingView.snp.width)
            const.centerX.equalTo(totalPaddingView.snp.centerX)
        }
        emailTextField.snp.makeConstraints { const in
            const.width.equalToSuperview()
            const.height.equalTo(30)
        }
        pwdTextField.snp.makeConstraints { const in
            const.width.equalToSuperview()
            const.height.equalTo(30)
        }
        invalidLabel.snp.makeConstraints { const in
            const.top.equalTo(loginInfoSectionStackView.snp.bottom).offset(5)
            const.leading.equalTo(loginInfoSectionStackView.snp.leading)
            const.height.equalTo(20)
        }
        loginButton.snp.makeConstraints { const in
            const.top.equalTo(loginInfoSectionStackView.snp.bottom).offset(30)
            const.width.equalTo(loginInfoSectionStackView.snp.width)
            const.height.equalTo(30)
            const.centerX.equalTo(view.snp.centerX)
        }
        findPwdButton.snp.makeConstraints { const in
            const.centerX.equalToSuperview()
            const.top.equalTo(loginButton.snp.bottom).offset(5)
            const.height.equalTo(15)
        }
        
        socialLoginButtonAnchorView.snp.makeConstraints { const in
            const.centerX.equalToSuperview()
            const.bottom.equalTo(signUpButton)
            const.top.equalTo(findPwdButton.snp.bottom).offset(10)
            const.width.equalToSuperview()
        }
        socialLoginButtonStackView.snp.makeConstraints { const in
            const.centerX.equalToSuperview()
            const.centerY.equalToSuperview()
            const.width.equalToSuperview().multipliedBy(0.75)
            const.height.equalTo(100)
        }
        signUpButton.snp.makeConstraints { const in
            const.centerX.equalToSuperview()
            const.bottom.equalToSuperview().offset(-10)
            const.width.equalTo(100)
            const.height.equalTo(15)
        }
    }
    
    func setButtonAction() {
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }
    func setDelegate() {
        emailTextField.delegate = self
        pwdTextField.delegate = self
    }
    @objc func loginButtonPressed() {
        
        pwdTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        self.isLoading.toggle()
        if isLoading {
            loginButton.startIndicator()
        } else {
            loginButton.stopIndicator()
        }
        
        
        guard let email = emailTextField.text else { return }
        guard let password = pwdTextField.text else { return }
        
        let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._&+-]+@[A-Z0-9a-z.-]+[.]+[A-Za-z]{2,20}", options: NSRegularExpression.Options.caseInsensitive)
        let textToNS = email as NSString
        let emailCheck = regex?.matches(in: email, options: [], range: NSRange(location: 0, length: textToNS.length)).map{textToNS.substring(with: $0.range)}
        
        if emailCheck!.isEmpty || email == "" {
            self.invalidLabel.text = "이메일을 정확하게 입력하세요."
            UIView.animate(withDuration: 0.2) {
                self.invalidLabel.snp.remakeConstraints({ (m) in
                    m.top.equalTo(self.pwdTextField.snp.bottom).offset(5)
                    m.leading.equalTo(self.pwdTextField.snp.leading).offset(5)
                })
                self.view.layoutIfNeeded()
            }
            return
        } else if password == "" || password.count < 6 {
            self.invalidLabel.text = "비밀번호를 6자리 이상 입력해 주세요."
            UIView.animate(withDuration: 0.2) {
                self.invalidLabel.snp.remakeConstraints({ (m) in
                    m.top.equalTo(self.pwdTextField.snp.bottom).offset(5)
                    m.leading.equalTo(self.pwdTextField.snp.leading).offset(5)
                })
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc func signUpButtonPressed() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewSB") as! SignUpViewController
        self.present(vc, animated: true, completion: nil)
    }
}


extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        pwdTextField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

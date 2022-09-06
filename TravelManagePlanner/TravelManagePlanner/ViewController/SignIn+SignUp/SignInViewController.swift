//
//  SignInViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/02.
//

import UIKit
import SnapKit

protocol SignInButtonPressed {
    func validateUserInfo()
  }

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    var signInViewModel: SignInViewModel!
    
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
        textField.textContentType = .password
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var invalidLabel: UILabel = {
        var label = UILabel()
        label.alpha = 0.0
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "이메일을 정확하게 입력하세요."
        label.textColor = .red
        return label
    }()
    
    lazy var loginButton: LoadingButton = {
        var button = LoadingButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(GlobalConstants.Color.Text.signInButtonTextColor, for: .normal)
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
    
    lazy var signUpStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    lazy var signUpLabel: UILabel = {
        var label = UILabel()
        label.text = "회원이 아니신가요?"
        label.textColor = GlobalConstants.Color.Text.signUpLabelTextColor
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var signUpButton: UIButton = {
        var button = UIButton()
        button.setTitle("새 계정 만들기", for: .normal)
        button.setTitleColor(GlobalConstants.Color.Text.signUpButtonTextColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    lazy var findPwdButton: UIButton = {
        var button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(GlobalConstants.Color.Text.findPasswordButtonTextColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInViewModel = SignInViewModel()
        callDataToUIUpdateFromVM()
        setDelegate()
        setLayout()
        setButtonAction()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Layout Setting Section
    func setLayout() {
        
        view.backgroundColor = GlobalConstants.Color.Background.themeColor
        
        view.addSubview(totalPaddingView)
        totalPaddingView.addSubview(logoImageAnchorView)
        logoImageAnchorView.addSubview(logoImageView)
        
        totalPaddingView.addSubview(invalidLabel)
        
        totalPaddingView.addSubview(loginInfoSectionStackView)
        
        loginInfoSectionStackView.addArrangedSubview(emailTextField)
        loginInfoSectionStackView.addArrangedSubview(pwdTextField)
        
        view.bringSubviewToFront(loginInfoSectionStackView)
        view.bringSubviewToFront(pwdTextField)
        
        totalPaddingView.addSubview(loginButton)
        
        totalPaddingView.addSubview(findPwdButton)
        
        totalPaddingView.addSubview(socialLoginButtonAnchorView)
        socialLoginButtonAnchorView.addSubview(socialLoginButtonStackView)
        
        totalPaddingView.addSubview(signUpStackView)
        signUpStackView.addArrangedSubview(signUpLabel)
        signUpStackView.addArrangedSubview(signUpButton)
        
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
            const.height.equalTo(20)
            const.top.equalTo(self.pwdTextField.snp.bottom).offset(5)
            const.leading.equalTo(self.pwdTextField.snp.leading).offset(5)
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
        signUpStackView.snp.makeConstraints { const in
            const.centerX.equalToSuperview()
            const.bottom.equalToSuperview().offset(-10)
            const.height.equalTo(15)
        }
        signUpLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        signUpButton.snp.makeConstraints { const in
            const.height.equalTo(15)
        }
    }
    
    func callDataToUIUpdateFromVM() {
        signInViewModel.loadingStarted.bind { [weak self] in
            self?.loginButton.startIndicator()
            print($0)
        }
        signInViewModel.loadingEnded.bind { [weak self] in
            self?.loginButton.stopIndicator()
            print($0)
        }
        signInViewModel.userInfoInputErrorMessage.bind { [weak self] in
            print("ErroMessage Bind ",$0)
            self?.invalidLabel.text = $0
            self?.invalidLabel.alpha = 1.0
            self?.view.layoutIfNeeded()
        }
        signInViewModel.loginSuccess.bind { [weak self] in
            print("login 성공여부: ", $0)
            if $0 {
                guard let tabbar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarControllerSB") as? TabbarController else { fatalError() }
                tabbar.modalPresentationStyle = .fullScreen
                self!.present(tabbar, animated: true, completion: nil)
            }
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
    
    // MARK: - Action Section
    @objc func loginButtonPressed() {
        
        guard let email = emailTextField.text else { return }
        guard let password = pwdTextField.text else { return }
        
        signInViewModel.updateUserEmail(email: email)
        signInViewModel.updateUserPwd(password: password)
        
        switch signInViewModel.validateUserInformation() {
        case .invalidEmail:
            self.invalidLabel.alpha = 1.0
            self.view.layoutIfNeeded()
        case .invalidPwd:
            self.invalidLabel.alpha = 1.0
            self.view.layoutIfNeeded()
        case .success:
            self.invalidLabel.alpha = 0.0
            self.view.layoutIfNeeded()
            login()
        }
    }
    
    @objc func signUpButtonPressed() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpSB") as? SignUpViewController else { fatalError() }
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func login() {
        if !isLoading {
            loginButton.startIndicator()
            self.isLoading.toggle()
        }
        signInViewModel.login()
    }
}


extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            pwdTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        invalidLabel.alpha = 0.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//
//  DetaileSettingViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/04.
//
import UIKit
import SnapKit

class DetaileSettingViewController: UIViewController {
    var themeViewModel = ThemeViewModel()
    
    //여행 제목 타이틀
    lazy var journeyTitle: UILabel = {
        let label = UILabel()
        label.text = "여행 제목"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        //        label.font = UIFont(name: "TMONBlack", size: 40)
        
        return label
    }()
    
    lazy var journeyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "여행 제목 입력"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.3
        
        return textField
    }()
    
    
    // 가는 날 라벨
    lazy var dayToGoLabel: UILabel = {
        let label = UILabel()
        label.text = "가는 날"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    
    
    lazy var dayToGocalendar: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(datePickerAction(_:)), for: .valueChanged)
        
        // 오늘이전날짜 선택비활성
        var components = DateComponents()
        components.day = 0
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        datePicker.minimumDate = minDate
        
        //        datePicker.preferredDatePickerStyle = .compact
        
        return datePicker
    }()
    
    @objc func datePickerAction(_ sender: UIDatePicker) {
        // 아무동작도 안하고 선택한 날짜만 print해주는 중
        print(sender.date)
    }
    
    // 오는 날 라벨
    lazy var dayToComeLabel: UILabel = {
        let label = UILabel()
        label.text = "오는 날"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    
    
    //    // 오는날 달력 구현부
    //    lazy var dayToComecalendar: UILabel = {
    //        let label = UILabel()
    //        label.text = "오는 날(달력)"
    //        label.font = UIFont.systemFont(ofSize: 22)
    //        label.textColor = .black
    //
    //        return label
    //    }()
    
    lazy var dayToComecalendar: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(datePickerAction(_:)), for: .valueChanged)
        
        // 오늘이전날짜 선택비활성
        var components = DateComponents()
        components.day = 0
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        datePicker.minimumDate = minDate
        //        datePicker.preferredDatePickerStyle = .compact
        
        return datePicker
    }()
    
    
    // 가는날 스택뷰
    lazy var dayToGoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayToGoLabel, dayToGocalendar])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    // 오는날 스택뷰
    lazy var dayToComeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayToComeLabel, dayToComecalendar])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    // 가는, 오는날 모든 스택뷰
    lazy var dayToAllStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayToGoStack, dayToComeStack])
        stackView.axis = .horizontal
        stackView.spacing = 40
        return stackView
    }()
    
    // 인원 수
    lazy var numPeople: UILabel = {
        let label = UILabel()
        label.text = "인원 수"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    // 인원 수 텍스트 필드
    lazy var numPeopleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "1" // 디폴트값 설정해야함
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.3
        
        return textField
    }()
    
    // 인원 수 추가, 감소 버튼
    // 구현부
    
    // 인원 수 모든 스택뷰
    lazy var numPeoPleAllStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numPeople, numPeopleTextField])
        stackView.axis = .horizontal
        stackView.spacing = 40
        return stackView
    }()
    
    // 예산
    lazy var budget: UILabel = {
        let label = UILabel()
        label.text = "예산"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    // 예산 금액 수치화
    lazy var budgetAmount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    // 예산 스택뷰
    lazy var budgetStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [budget, budgetAmount])
        stackView.axis = .horizontal
        stackView.spacing = 1
        return stackView
    }()
    
    // 예산 슬라이더
    lazy var budgetSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 200000
        slider.maximumValue = 2000000
        slider.value = 200000
//        self.budgetAmount.text = "22"
        return slider
    }()
    
    @objc
    func sliderAction(_ sender: UISlider) {
        sender.value = budgetSlider.value
        budgetAmount.text = String(format: "%.0f", sender.value)
        
    }
    
    // 예산 모든 스택뷰
    lazy var budgetAllStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [budgetStack, budgetSlider])
        stackView.axis = .vertical
        //      stackView.spacing = 40
        return stackView
    }()
    
    // 취소 버튼
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for : .normal)
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 0.6), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.backgroundColor = .clear
        
        return button
    }()
    
    
    // 다음 버튼
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for : .normal)
        button.setTitleColor(UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 0.6), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.backgroundColor = .clear
//        button.addTarget(self, action: #selector(dataSendButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    // 뒤로가기, 확인 바텀버튼 (stack View 사용)
    lazy var bottomButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancleButton, nextButton])
        stackView.axis = .horizontal
        stackView.spacing = 120
        
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalConstants.Color.Background.themeColor
        setUpView()
        setLayout()
        setDelegate()
        setButtonAction()
        
        budgetSlider.addTarget(self, action: #selector(self.sliderAction(_:)), for: .valueChanged)
        nextButton.addTarget(self, action: #selector(self.nextButtonAction(_:)), for: .touchUpInside)
    }
    
//    @objc func dataSendButtonAction() {
//        themeViewModel.themeData = self.journeyTextField.text ?? "title is nil"
//    }
    
    
    @objc func nextButtonAction(_ sender: UIButton) {
        themeViewModel.DataCheck()
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil)
            .instantiateViewController(withIdentifier: "DestiSearchViewSB") as! DestiSearchViewController
            navigationController?.pushViewController(nextView, animated: true)
    }
    
    func setButtonAction() {
        //        // 달력 바텀뷰
        //        dayToGocalendar.addTarget(self, action: #selector(presentModalController), for: .touchUpInside)
    }
    
    func setUpView() {
        view.addSubview(journeyTitle)
        view.addSubview(journeyTextField)
        view.addSubview(dayToAllStack)
        view.addSubview(numPeoPleAllStack)
        view.addSubview(budgetAllStack)
        view.addSubview(bottomButtonStack)
    }
    
    
    
    
    func setDelegate(){
        
    }
    
    
    // 바텀뷰 불러오기
    //    @objc func presentModalController() {
    //        let vc = CustomModalViewController()
    //        vc.modalPresentationStyle = .overCurrentContext
    //        // Keep animated value as false
    //        // Custom Modal presentation animation will be handled isn VC itself
    //        self.present(vc, animated: true)
    //        print("들어오긴하니?")
    //    }
    
    func setLayout() {
        journeyTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        journeyTextField.snp.makeConstraints {
            $0.top.equalTo(journeyTitle.snp.bottom).multipliedBy(1)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        dayToAllStack.snp.makeConstraints {
            $0.top.equalTo(journeyTextField.snp.bottom).multipliedBy(1.2)
            $0.leading.equalToSuperview().offset(24)
        }
        
        numPeoPleAllStack.snp.makeConstraints {
            $0.top.equalTo(dayToAllStack.snp.bottom).multipliedBy(1.2)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        budgetAllStack.snp.makeConstraints {
            $0.top.equalTo(numPeoPleAllStack.snp.bottom).multipliedBy(1.2)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        bottomButtonStack.snp.makeConstraints {
            $0.top.equalTo(budgetAllStack.snp.bottom).multipliedBy(1.3)
            //            $0.leading.equalTo(budgetAllStack).offset(50)
            $0.centerX.equalToSuperview()
            
            //           $0.trailing.equalToSuperview().offset(-24)
        }
        
        
        
        //        NSLayoutConstraint.activate([
        //         dayToGocalendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        //         dayToGocalendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        //         dayToGocalendar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        //        ])
        //
        //        dayToGocalendar.snp.makeConstraints { make in
        //        }
        
        
    }
    
    
    // main에 있는 두번째화면 불러오기(스토리보드 활용)
    let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "AccomoViewSB") as! AccomoViewController
}

//
//  RestaurantCalendarViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//
import UIKit
import SnapKit
import FSCalendar

class RestaurantCalendarViewController: UIViewController {
    
    // 알림창 구현
    let alert = UIAlertController(title: "", message: "장바구니에 추가 되었습니다.", preferredStyle: UIAlertController.Style.alert)
    
    let addAlert = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: nil)
    
    // 뷰모델 소지
    let homeTabViewModel = HomeTabViewModel()
    
    let dateFormatter = DateFormatter()
    
    var restaurantName: String = ""
    var restaurantPlace: String = ""
    var restaurantSIdx: Int = 0
    
    var selectVisitDate = ""
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    // 2
    let maxDimmedAlpha: CGFloat = 0.5
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    lazy var fscCalendar: FSCalendar = {
        let calendar = FSCalendar()
        
        //선택 버튼색상
        calendar.appearance.selectionColor = UIColor(red: 104/255, green: 209/255, blue: 148/255, alpha: 1)
        calendar.backgroundColor = UIColor(red: 228/255, green: 245/255, blue: 255/255, alpha: 1)
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.allowsMultipleSelection = false // 다중선택기능
        calendar.appearance.todayColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1)
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        calendar.layer.cornerRadius = 20
        return calendar
    }()
    
    // 선택한 식당 명
    lazy var selectRestaurantName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
//        label.textAlignment = .center
        label.text = restaurantName
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    // 선택한 숙박장소 지역명
    lazy var selectRestaurantPlace: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
//        label.textAlignment = .center
        label.text = restaurantPlace
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    // 다시선택 버튼
    lazy var reSelectButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시 선택", for : .normal)
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 0.6), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        
        return button
    }()
    
    lazy var restaurantAddButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가 하기", for : .normal)
        button.setTitleColor(UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 0.6), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        
        return button
    }()
    
    
    // 바텀 버튼 스택
    lazy var bottomButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reSelectButton, restaurantAddButton])
        stackView.axis = .horizontal
        stackView.spacing = 120
        
        return stackView
    }()
    // BottomCalendar 높이
    let defaultHeight: CGFloat = 500
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setUpView()
        setLayout()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        fscCalendar.delegate = self
        fscCalendar.dataSource = self
        
        restaurantAddButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    func setUpView() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        view.addSubview(selectRestaurantName)
        view.addSubview(selectRestaurantPlace)
        view.addSubview(fscCalendar)
        view.addSubview(bottomButtonStack)
    }
    
    func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        selectRestaurantName.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).multipliedBy(1.03)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        selectRestaurantPlace.snp.makeConstraints {
            $0.top.equalTo(selectRestaurantName.snp.bottom).multipliedBy(1.02)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        fscCalendar.snp.makeConstraints {
            $0.top.equalTo(selectRestaurantPlace.snp.bottom).multipliedBy(1.02)
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(80)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        bottomButtonStack.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        // 6. Set container to default height
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        // 7. Set bottom constant to 0
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func animateDismissView() {
        // hide main container view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.5) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.5) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: true)
        }
    }
    
    // 식당 추가하기
    @objc func addButtonAction() {
        // 추가시에 present화면 dismiss설정하기
        let sIdx = String(restaurantSIdx)
        let vDate = self.selectVisitDate
        let leaveDate = self.selectVisitDate
       
//        animateDismissView()
        self.dismiss(animated: true)
        self.present(alert, animated: true)
        
        
        let accomoShopData = HomeTabRequestData(sIdx: sIdx, vDate: vDate, leaveDate: leaveDate)
       
        homeTabViewModel.updateRecommendData(shopList: [accomoShopData])
        
    }
}

extension RestaurantCalendarViewController:FSCalendarDataSource {
    
}

extension RestaurantCalendarViewController:FSCalendarDelegate {
  
}

extension RestaurantCalendarViewController:FSCalendarDelegateAppearance {
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        
        // 선택한 날짜 담기
        dateFormatter.dateFormat = "yyyyMMdd"
        self.selectVisitDate = dateFormatter.string(from: date)
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
}


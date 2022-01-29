//
//  CalendarModalViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/27.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarModalViewController: UIViewController {
    let fscCalendarDateFormat = DateFormatter()
   
    
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
        calendar.allowsMultipleSelection = true
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
//        calendar.borderRadius = 1.2
        
        return calendar
    }()
    
    // 선택한 숙박업소 명
    lazy var selectAccomName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
//        label.textAlignment = .center
        label.text = "숙박장소 명"
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    // 선택한 숙박장소 지역명
    lazy var selectAccomoPlace: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
//        label.textAlignment = .center
        label.text = "지역 명"
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    // BottomCalendar 높이
    let defaultHeight: CGFloat = 420
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setUpView()
        setLayout()
        fscCalendarDateFormat.dateFormat = "yyyy-MM-dd"
        
        fscCalendar.delegate = self
        fscCalendar.dataSource = self
    }
    
    func setUpView() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        view.addSubview(selectAccomName)
        view.addSubview(selectAccomoPlace)
        view.addSubview(fscCalendar)
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
        
        selectAccomName.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        selectAccomoPlace.snp.makeConstraints {
            $0.top.equalTo(selectAccomName.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        fscCalendar.snp.makeConstraints {
            $0.top.equalTo(selectAccomoPlace.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        // 6. Set container to default height
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        // 7. Set bottom constant to 0
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}

extension CalendarModalViewController:FSCalendarDataSource {
    
}

extension CalendarModalViewController:FSCalendarDelegate {
  
}

extension CalendarModalViewController:FSCalendarDelegateAppearance {
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(fscCalendarDateFormat.string(from: date) + " 선택됨")
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(fscCalendarDateFormat.string(from: date) + " 해제됨")
    }
}

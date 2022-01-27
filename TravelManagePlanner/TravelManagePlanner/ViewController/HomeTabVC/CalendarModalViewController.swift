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
        
        
        return calendar
    }()
    
    // BottomCalendar 높이
    let defaultHeight: CGFloat = 380
    
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
        view.addSubview(fscCalendar)
    }
    func setLayout() {
        // 4. Add subviews
        
//        dimmedView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        
        fscCalendar.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(30)
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

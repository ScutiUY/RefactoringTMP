//
//  reviewViewController.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/13.
//

import UIKit
import Then

class ReviewWriteViewController: UIViewController {

    // MARK: - Properties
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    let headerview = UIView()
    
    lazy var headerTitle = UILabel().then({
        $0.text = "리뷰를 작성하여\n여행을 함께 공유해요!"
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.numberOfLines = 0
        $0.textColor = #colorLiteral(red: 0.3333333333, green: 0.7254901961, blue: 0.737254902, alpha: 1)
    })
    
    lazy var travelTitle = UILabel().then {
        $0.text = "제목을 입력하세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var travelTextField = UITextField().then {
        $0.placeholder = "민수와 제주도 우정여행"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
    }
    
    lazy var hashtagTitle = UILabel().then {
        $0.text = "해쉬태그를 입력해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var hashtagTextField = UITextField().then {
        $0.placeholder = "#제주 #우정 #10년지기"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
    }
    
    lazy var foodTitle = UILabel().then {
        $0.text = "다녀온 맛집이 어디인가요?"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var foodTextField = UITextField().then {
        $0.placeholder = "#돌하르방삼겹살 #장독김치국수"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
    }

    lazy var sleepTitle = UILabel().then {
        $0.text = "어떤 숙소에서 머무르셨나요?"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var sleepTextField = UITextField().then {
        $0.placeholder = "#델리호텔 #예스호텔"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
    }
    
    lazy var reviewTitle = UILabel().then {
        $0.text = "리뷰"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var reviewTextField = UITextField().then {
        $0.placeholder = "리뷰를 등록해주세요."
        $0.backgroundColor = .white
        $0.frame.size.height = 100
        $0.frame.size.width = 200
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
    }
    
    lazy var photoTitle = UILabel().then {
        $0.text = "사진을 등록 해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Setup()
        headerSetUp()
        bodySetup()
    }
    

    // MARK: - Helpers
    
    func Setup()
    {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            $0.height.greaterThanOrEqualTo(view.snp.height)
        }
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
    }
    
    func headerSetUp()
    {
        contentView.addSubview(headerview)
        contentView.addSubview(headerTitle)
        headerview.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.2)
        }
        headerTitle.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(headerview.snp.height).multipliedBy(0.7)
            $0.bottom.equalTo(headerview.snp.bottom)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }

    
    func bodySetup()
    {
        contentView.addSubview(travelTitle)
        contentView.addSubview(travelTextField)
        contentView.addSubview(hashtagTitle)
        contentView.addSubview(hashtagTextField)
        contentView.addSubview(foodTitle)
        contentView.addSubview(foodTextField)
        contentView.addSubview(sleepTitle)
        contentView.addSubview(sleepTextField)
        contentView.addSubview(reviewTitle)
        contentView.addSubview(reviewTextField)
        contentView.addSubview(photoTitle)

        travelTitle.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(headerview.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        travelTextField.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(travelTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        hashtagTitle.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(travelTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        hashtagTextField.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(hashtagTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        foodTitle.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(hashtagTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        foodTextField.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(foodTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        sleepTitle.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(foodTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        sleepTextField.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(sleepTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        reviewTitle.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(sleepTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        reviewTextField.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(reviewTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        photoTitle.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(reviewTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
    }
    
}

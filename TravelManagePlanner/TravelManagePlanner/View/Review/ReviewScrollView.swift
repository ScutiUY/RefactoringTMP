//
//  ReviewScrollView.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/13.
//

import UIKit

class ReviewScrollView: UIScrollView {

    let ReviewContentView = UIView()
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
    
    lazy var travelTitleTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 0.8
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 5
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
        $0.clipsToBounds = false
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.4
    }
    
    lazy var hashtagTitle = UILabel().then {
        $0.text = "해쉬태그를 입력해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var hashtagTextView = UITextView().then {
        if ($0.text.isEmpty) {
            $0.text = "해쉬태그를 작성해주세요."
            $0.textColor = .lightGray
        }
        $0.layer.borderWidth = 0.8
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
        $0.clipsToBounds = false
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.4
    }
    
    lazy var dateTitle = UILabel().then {
        $0.text = "언제부터 언제까지 다녀오셨나요?"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var dateTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 16)
        $0.layer.borderWidth = 0.8
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
        $0.clipsToBounds = false
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.4
    }
    
    lazy var reviewTitle = UILabel().then {
        $0.text = "리뷰"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var reviewTextView = UITextView().then {
        if ($0.text.isEmpty) {
            $0.text = "리뷰를 작성해주세요."
            $0.textColor = .lightGray
        }
        $0.layer.borderWidth = 0.8
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        $0.clipsToBounds = false
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.4

    }
    
    lazy var photoTitle = UILabel().then {
        $0.text = "사진을 등록 해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var photoButton = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.setTitleColor(.black, for: .normal)
        $0.frame(forAlignmentRect: CGRect(x: 10, y: 10, width: 10, height: 10))
        $0.backgroundColor = #colorLiteral(red: 0.8784313798, green: 0.8784313798, blue: 0.8784313798, alpha: 1)
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
    }
    
    lazy var reviewPhotoCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        flowlayout.scrollDirection = .horizontal
        flowlayout.minimumLineSpacing = 20
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.backgroundColor = UIColor(red: 243/255, green: 255/255, blue: 251/255, alpha: 1)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        headerSetUp()
        bodySetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        headerSetUp()
        bodySetup()
    }
    
    func setUp()
    {
        self.addSubview(ReviewContentView)
        
        ReviewContentView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.trailing.equalTo(self.snp.trailing)
            $0.leading.equalTo(self.snp.leading)
            $0.bottom.equalTo(self.snp.bottom)
            $0.width.equalTo(self.snp.width)
//            $0.height.greaterThanOrEqualTo(view.snp.height)
        }
    }
    
    func headerSetUp()
    {
        self.addSubview(headerview)
        ReviewContentView.addSubview(headerTitle)
        headerview.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width)
            $0.top.equalTo(ReviewContentView.snp.top)
            $0.height.equalTo(ReviewContentView.snp.height).multipliedBy(0.2)
        }
        headerTitle.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(headerview.snp.height).multipliedBy(0.7)
            $0.bottom.equalTo(headerview.snp.bottom)
            $0.centerX.equalTo(ReviewContentView.snp.centerX)
        }
    }

    
    func bodySetup()
    {
        ReviewContentView.addSubview(travelTitle)
        ReviewContentView.addSubview(travelTitleTextView)
        ReviewContentView.addSubview(hashtagTitle)
        ReviewContentView.addSubview(hashtagTextView)
        ReviewContentView.addSubview(dateTitle)
        ReviewContentView.addSubview(dateTextView)
        ReviewContentView.addSubview(reviewTitle)
        ReviewContentView.addSubview(reviewTextView)
        ReviewContentView.addSubview(photoTitle)
        ReviewContentView.addSubview(photoButton)
        ReviewContentView.addSubview(reviewPhotoCollectionView)
        
        travelTitleTextView.isScrollEnabled = false
        travelTitleTextView.isEditable = false
        dateTextView.isScrollEnabled = false
        dateTextView.isEditable = false

        travelTitle.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(headerview.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        travelTitleTextView.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(travelTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        hashtagTitle.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(travelTitleTextView.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        hashtagTextView.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(hashtagTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        dateTitle.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(hashtagTextView.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        dateTextView.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(dateTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        reviewTitle.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(dateTextView.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(200)
            $0.top.equalTo(reviewTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        photoTitle.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(reviewTextView.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        photoButton.snp.makeConstraints {
            $0.top.equalTo(photoTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(30)
            $0.height.equalTo(30)
        }
        
        
        reviewPhotoCollectionView.snp.makeConstraints {
            $0.width.equalTo(ReviewContentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(250)
            $0.top.equalTo(photoButton.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    
}

//
//  TourAreaViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//

import UIKit

// 추천놀거리(관광지)
class TourAreaViewController: UIViewController {
    
  
    
    // 뷰모델 소유
    let destiSearchViewModel = DestiSearchViewModel()
    let cellID = "Cell"
    
    lazy var tourAreaTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "놀거리"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    lazy var basket: UIButton = {
        let button = UIButton()
        button.setTitle("바구니", for : .normal)
        
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 0.6), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = .clear
        
        return button
    }()
    
    lazy var tourAreaHeadStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tourAreaTitleLabel, basket])
        stackView.axis = .horizontal
        //        stackView.spacing = 5
        
        return stackView
    }()
    
    // 테이블뷰를 활용하여 추천지 구현하기
    lazy var tourAreaTableView: UITableView = {
        let tableVIew = UITableView()
        tableVIew.backgroundColor = .clear
        return tableVIew
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GlobalConstants.Color.Background.themeColor
        
        setObserver()
        setUpView()
        setLayout()
        setDelegate()
    }
    
    func setUpView() {
        view.addSubview(tourAreaHeadStack)
        view.addSubview(tourAreaTableView)
    }
    
    func setLayout() {
        tourAreaHeadStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).multipliedBy(1.1)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        tourAreaTableView.snp.makeConstraints {
            $0.top.equalTo(tourAreaHeadStack.snp.bottom).multipliedBy(1.1)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.bottom.equalToSuperview().offset(-30)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func setDelegate() {
        tourAreaTableView.dataSource = self
        tourAreaTableView.delegate = self
        
        tourAreaTableView.register(TourAreaViewCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
    
    func setObserver() {
        destiSearchViewModel.getData()
        
        destiSearchViewModel.loadingStarted = {
            
        }
        destiSearchViewModel.loadingEnded = {
            
        }
        destiSearchViewModel.dataUpdated = {
            self.tourAreaTableView.reloadData()
        }
    }
    
}


// cellHeight 지정
extension TourAreaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 4
    }
    
}

extension TourAreaViewController: UITableViewDataSource {
    // 큰 섹션수(Defalut 1)
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 1: 숙박, 2: 식당, 3: 놀거리
        let tableCount = destiSearchViewModel.getDestiSearchCount(categoryIdx: "3")
        
        return tableCount
    }
    
    // 테이블 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TourAreaViewCell
        cell.backgroundColor = .clear
        
        // 카테고리가 놀거리 인것만  == 3
        let shopData = destiSearchViewModel.getShopData(idx: indexPath.row, categoryIdx: "3")
        
        let url = URL(string: shopData.imgUrl)
        let data = try! Data(contentsOf: url!)
        
        cell.tourAreaImg.image = UIImage(data: data)
        cell.tourAreaTitle.text = shopData.name
        cell.tourAreaSubTitle.text = shopData.content
        cell.cellDelegate = self
        
        
        //        cell.contentView.isUserInteractionEnabled = false
        
        return cell
    }
}

extension TourAreaViewController:ContentsMainTextDelegate {
    func categoryButtonTapped() {
        print("버튼 기능 구현")
        
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "TourAreaCalendarViewSB") as! TourAreaCalendarViewController
        
        
        // 다음화면에서 바텀탭 없애기
        nextView.hidesBottomBarWhenPushed = true
        self.present(nextView, animated: true)
    }
}

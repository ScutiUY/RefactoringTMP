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
    let tourAreaCategory:String = "3"
    
    lazy var tourAreaTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "놀거리"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    lazy var basket: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "basket"), for: .normal)
        button.setImageTintColor(GlobalConstants.Color.IconColor.basketColor)
        button.backgroundColor = .clear
        
        return button
    }()
    
    // 테이블뷰를 활용하여 추천지 구현하기
    lazy var tourAreaTableView: UITableView = {
        let tableVIew = UITableView()
        tableVIew.backgroundColor = .clear
        tableVIew.separatorStyle = .none // 가로라인 없애기
        
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
        view.addSubview(tourAreaTitleLabel)
        view.addSubview(basket)
        view.addSubview(tourAreaTableView)
    }
    
    func setLayout() {
        tourAreaTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        basket.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(tourAreaTableView.snp.top).offset(-27)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        tourAreaTableView.snp.makeConstraints {
            $0.top.equalTo(tourAreaTitleLabel.snp.bottom).multipliedBy(1.1)
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
    
    // 셀높이 간격
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 3.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // 디테일뷰 구현하기
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
        let tableCount = destiSearchViewModel.getDestiSearchCount(categoryIdx: tourAreaCategory)
        
        return tableCount
    }
    
    // 테이블 화면데이터구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TourAreaViewCell
        cell.backgroundColor = .clear
        
        // cell 선택시 백그라운드 색상 없애기
        let cellBGView = UIView()
        cellBGView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cell.selectedBackgroundView = cellBGView
        
        // 선택된 해당데이터 모델[배열]가져오기
        let shopData = destiSearchViewModel.getShopData(idx: indexPath.row, categoryIdx: tourAreaCategory)
        
        let url = URL(string: shopData.imgUrl)
        let data = try! Data(contentsOf: url!)
        
        cell.tourAreaImg.image = UIImage(data: data)
        cell.tourAreaTitle.text = shopData.name
        cell.tourAreaSubTitle.text = shopData.content
        cell.place = shopData.area
        cell.sIdx = shopData.idx
        
        cell.cellDelegate = self
        
        return cell
    }
}

extension TourAreaViewController:ContentsMainTextDelegate {
    func categoryButtonTapped(title: String, place: String, sIdx: Int) {
        print("버튼 기능 구현")
        
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "TourAreaCalendarViewSB") as! TourAreaCalendarViewController
        
        nextView.tourAreaName = title
        nextView.tourAreaPlace = place
        nextView.tourAreaSIdx = sIdx
        
        // 다음화면에서 바텀탭 없애기
        nextView.hidesBottomBarWhenPushed = true
        self.present(nextView, animated: true)
    }
}

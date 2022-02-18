//
//  RestaurantViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    // 뷰모델 소유
    let destiSearchViewModel = DestiSearchViewModel()
    let cellID = "Cell"
    let restaurantCategory:String = "2"
    
    lazy var restaurantTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "식당"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    lazy var basket: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "basket"), for: .normal)
        
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 0.6), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = .clear
        
        return button
    }()
    
    // 테이블뷰를 활용하여 추천지 구현하기
    lazy var restaurantTableView: UITableView = {
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
        view.addSubview(restaurantTitleLabel)
        view.addSubview(basket)
        view.addSubview(restaurantTableView)
    }
    
    func setLayout() {
        restaurantTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        basket.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(restaurantTableView.snp.top).offset(-35)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        restaurantTableView.snp.makeConstraints {
            $0.top.equalTo(restaurantTitleLabel.snp.bottom).multipliedBy(1.1)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.bottom.equalToSuperview().offset(-30)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func setDelegate() {
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        
        restaurantTableView.register(RestaurantViewCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
    
    func setObserver() {
        destiSearchViewModel.getData()
        
        destiSearchViewModel.loadingStarted = {
            
        }
        destiSearchViewModel.loadingEnded = {
            
        }
        destiSearchViewModel.dataUpdated = {
            self.restaurantTableView.reloadData()
        }
    }
    
}
    


// cellHeight 지정
extension RestaurantViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 3.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // 디테일뷰 구현하기
    }

}

extension RestaurantViewController: UITableViewDataSource {
    // 큰 섹션수(Defalut 1)
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    // cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let tableCount = destiSearchViewModel.getDestCount(categoryIdx: restaurantCategory)
        
        return tableCount
    }
    
    // 테이블 화면데이터구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RestaurantViewCell
        cell.backgroundColor = .clear
   
      
        
        // cell 선택시 백그라운드 색상 없애기
        let cellBGView = UIView()
        cellBGView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cell.selectedBackgroundView = cellBGView
        
        // 선택된 해당데이터 모델[배열]가져오기
        let shopData = destiSearchViewModel.getShopDataSepWithCategory(idx: indexPath.row, categoryIdx: restaurantCategory)
        
        let url = URL(string: shopData.imgUrl)
        let data = try! Data(contentsOf: url!)
        
        cell.restaurantImg.image = UIImage(data: data)
        cell.restaurantTitle.text = shopData.name
        cell.restaurantSubTitle.text = shopData.content
        cell.place = shopData.area
        cell.sIdx = shopData.idx
        
        cell.cellDelegate = self
        
        return cell
    }
}

extension RestaurantViewController:ContentsMainTextDelegate {
    // 달력 이동
    func categoryButtonTapped(title: String, place: String, sIdx: Int) {
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "RestaurantCalendarViewSB") as! RestaurantCalendarViewController
        
        nextView.restaurantName = title
        nextView.restaurantPlace = place
        nextView.restaurantSIdx = sIdx
        
        // 다음화면에서 바텀탭 없애기
        nextView.hidesBottomBarWhenPushed = true
        self.present(nextView, animated: true)
    }
    
    
}

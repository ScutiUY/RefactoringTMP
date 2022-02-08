//
//  RestaurantViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//

import UIKit

class RestaurantViewController: UIViewController {

    let cellID = "Cell"
    
    lazy var imgDataName = ["accomoA", "accomoB", "accomoC","accomoA", "accomoB", "accomoC"]
    
    var imgArray: [UIImage] {
        var img:[UIImage] = []
        
        for i in imgDataName {
            if let asImg = UIImage(named: i) {
                
                img.append(asImg)
            }else {
                print("Restaurant imgData is nil")
            }
        }
        return img
    }
    
    lazy var restaurantTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "식당"
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
    
    lazy var restaurantHeadStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [restaurantTitleLabel, basket])
        stackView.axis = .horizontal
//        stackView.spacing = 5
        
        return stackView
    }()
    
    // 테이블뷰를 활용하여 추천지 구현하기
    lazy var restaurantTableView: UITableView = {
        let tableVIew = UITableView()
        tableVIew.backgroundColor = .clear
        return tableVIew
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GlobalConstants.Color.Background.themeColor
        setUpView()
        setLayout()
        setDelegate()
    }
    
    func setUpView() {
        view.addSubview(restaurantHeadStack)
        view.addSubview(restaurantTableView)
    }
    
    func setLayout() {
        restaurantHeadStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).multipliedBy(1.1)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        restaurantTableView.snp.makeConstraints {
            $0.top.equalTo(restaurantHeadStack.snp.bottom).multipliedBy(1.1)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.bottom.equalToSuperview().offset(-150)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func setDelegate() {
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        
        restaurantTableView.register(RestaurantViewCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
    
}


// cellHeight 지정
extension RestaurantViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 4
    }

}

extension RestaurantViewController: UITableViewDataSource {
    // 큰 섹션수(Defalut 1)
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    // cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        imgDataName.count
    }
    
    // 테이블 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RestaurantViewCell
        cell.backgroundColor = .clear
        cell.cellLoadImage(imgDataName[indexPath.row])
        cell.restaurantTitle.text = imgDataName[indexPath.row]
        cell.restaurantSubTitle.text = "업소의 간단한 설명"
        cell.cellDelegate = self
        
    
//        cell.contentView.isUserInteractionEnabled = false
        
        return cell
    }
}

extension RestaurantViewController:ContentsMainTextDelegate {
    func categoryButtonTapped() {
        print("버튼 기능 구현")
        
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "RestaurantCalendarViewSB") as! RestaurantCalendarViewController
        
        // 다음화면에서 바텀탭 없애기
        nextView.hidesBottomBarWhenPushed = true
        self.present(nextView, animated: true)
    }
    
    
}

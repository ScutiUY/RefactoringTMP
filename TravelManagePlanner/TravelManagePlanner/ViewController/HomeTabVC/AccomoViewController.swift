//
//  AccomoViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/22.
//
import UIKit

// 숙박업소 추천지노출
class AccomoViewController: UIViewController {
    
    //  뷰모델 소유
    let homeTabViewModel = HomeTabViewModel()
    let cellID = "Cell"
    
    lazy var imgDataName = ["accomoA", "accomoB", "accomoC","accomoA", "accomoB", "accomoC"]
    
    var imgArray: [UIImage] {
        var img:[UIImage] = []
        
        for i in imgDataName {
            if let asImg = UIImage(named: i) {
                
                img.append(asImg)
            }else {
                print("Accomo imgData is nil")
            }
        }
        return img
    }
    
    lazy var accomoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "숙박"
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
    
    lazy var accomoHeadStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accomoTitleLabel, basket])
        stackView.axis = .horizontal
//        stackView.spacing = 5
        
        return stackView
    }()
    
    // 테이블뷰를 활용하여 추천지 구현하기
    lazy var accomoTableView: UITableView = {
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
        view.addSubview(accomoHeadStack)
        view.addSubview(accomoTableView)
    }
    
    func setLayout() {
        accomoHeadStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).multipliedBy(1.1)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        accomoTableView.snp.makeConstraints {
            $0.top.equalTo(accomoHeadStack.snp.bottom).multipliedBy(1.1)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.bottom.equalToSuperview().offset(-130)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func setDelegate() {
        accomoTableView.dataSource = self
        accomoTableView.delegate = self
        
        accomoTableView.register(AccomoViewCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
    
    func setObserver() {
        homeTabViewModel.getData()
        
        homeTabViewModel.loadingStarted = {
            
        }
        homeTabViewModel.loadingEnded = {
            
        }
        homeTabViewModel.dataUpdated = {
            self.accomoTableView.reloadData()
        }
        
        
    }
}


// cellHeight 지정
extension AccomoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 4
    }

}

extension AccomoViewController: UITableViewDataSource {
    // 큰 섹션수(Defalut 1)
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    // cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//      return  imgDataName.count
        
        return homeTabViewModel.getDestiSearchCount()
//        return 5
    }
    
    // 테이블 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AccomoViewCell
        cell.backgroundColor = .clear
        
        // 선택된 해당데이터 모델[배열]가져오기
        let shopData = homeTabViewModel.getShop(idx: indexPath.row)
        
//        cell.cellLoadImage(imgDataName[indexPath.row])
        
//        cell.accomoTitle.text = imgDataName[indexPath.row]
//        cell.accomoSubTitle.text = "업소의 간단한 설명"
        let url = URL(string: shopData.imgUrl)
        let data = try! Data(contentsOf: url!)
        
        cell.accomoImg.image = UIImage(data: data)
        cell.accomoTitle.text = shopData.name
        cell.accomoSubTitle.text = shopData.content
//
        cell.cellDelegate = self
        
//        cell.contentView.isUserInteractionEnabled = false
        
        return cell
    }
}

extension AccomoViewController:ContentsMainTextDelegate {
    func categoryButtonTapped() {
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "AccomoCalendarViewSB") as! AccomoCalendarViewController
        
        // 다음화면에서 바텀탭 없애기
        nextView.hidesBottomBarWhenPushed = true
        self.present(nextView, animated: true)
    }
    
    
}

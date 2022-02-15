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
    let destiSearchViewModel = DestiSearchViewModel()
    let cellID = "Cell"
    
    var firstaccomName: String = ""
    
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
            $0.bottom.equalToSuperview().offset(-30)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func setDelegate() {
        accomoTableView.dataSource = self
        accomoTableView.delegate = self
        
        accomoTableView.register(AccomoViewCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
    
    func setObserver() {
        destiSearchViewModel.getData()
        
        destiSearchViewModel.loadingStarted = {
            
        }
        destiSearchViewModel.loadingEnded = {
            
        }
        destiSearchViewModel.dataUpdated = {
            self.accomoTableView.reloadData()
        }
    }
}


// cellHeight 지정
extension AccomoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "AccomoCalendarViewSB") as! AccomoCalendarViewController
        
        nextView.accomoName = destiSearchViewModel.getTitle(idx: indexPath.row)
        nextView.accomoPlace = destiSearchViewModel.getArea(idx: indexPath.row)
        nextView.accomoSIdx = destiSearchViewModel.getSIdx(idx: indexPath.row)
        
        // 다음화면에서 바텀탭 없애기
        nextView.hidesBottomBarWhenPushed = true
        self.present(nextView, animated: true)
    }

}

extension AccomoViewController: UITableViewDataSource {
    // 큰 섹션수(Defalut 1)
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    // cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 1: 숙박, 2: 식당, 3: 놀거리
        let tableCount = destiSearchViewModel.getDestiSearchCount(categoryIdx: "1")
        
        return tableCount
    }
    
    // 테이블 화면데이터구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath)
        
        // 1. 가게Index 정보 를 cell안의 변수로 넘기고
        // 2. 선택 버튼 달력안에(
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AccomoViewCell
        cell.backgroundColor = .clear
        
        // 1: 숙박, 2: 식당, 3: 놀거리
        let shopData = destiSearchViewModel.getShopData(idx: indexPath.row, categoryIdx: "1")
        
        self.firstaccomName = shopData.name
        
        let url = URL(string: shopData.imgUrl)
        let data = try! Data(contentsOf: url!)
        
        cell.accomoImg.image = UIImage(data: data)
        cell.accomoTitle.text = shopData.name
        cell.accomoSubTitle.text = shopData.content
        cell.cellDelegate = self
        
        
        return cell
    }
}

extension AccomoViewController:ContentsMainTextDelegate {
    //달력 이동
    func categoryButtonTapped() {
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "AccomoCalendarViewSB") as! AccomoCalendarViewController
        
        nextView.accomoName = self.firstaccomName
        
        // 다음화면에서 바텀탭 없애기
        nextView.hidesBottomBarWhenPushed = true
        self.present(nextView, animated: true)
    }
}

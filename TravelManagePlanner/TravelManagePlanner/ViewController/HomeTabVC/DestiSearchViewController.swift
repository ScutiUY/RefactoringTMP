//
//  DestiSearchViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/08.
//
import UIKit
import Alamofire

// 검색기능
class DestiSearchViewController: UIViewController {
    
    // 테마 타이틀
    lazy var themeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "목적지 검색"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    lazy var userSearchBar: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "목적지를 입력해주세요"
        // 검색이후 나머지뷰 어둡게?
        searchController.obscuresBackgroundDuringPresentation = false
        
        // searchController를 navi의 searchController에 넣어줘야함
        self.navigationItem.searchController = searchController
//        self.navigationItem.title = "목적지 검색"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
       
        return searchController
    }()
    
    lazy var placeDataTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dataCell")
        
        return tableView
    }()
    
    var data: DestiSearchData = DestiSearchData(place: "")
    
    var filterCheck: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isEmpty = searchController?.searchBar.text?.isEmpty ?? false
        
        return isActive && isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GlobalConstants.Color.Background.themeColor
        setUpView()
        setLayout()
        setDelegate()
    }
    
    func setUpView() {
        view.addSubview(themeTitleLabel)
        view.addSubview(placeDataTable)
    }
    
    func setDelegate() {
        placeDataTable.dataSource = self
        placeDataTable.delegate = self
        userSearchBar.searchResultsUpdater = self
    }
    
    func setLayout() {
        themeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        placeDataTable.snp.makeConstraints {
            $0.top.equalToSuperview().multipliedBy(1.0).offset(0)
            $0.leading.equalToSuperview().multipliedBy(1.0).offset(0)
            $0.bottom.equalToSuperview().multipliedBy(1.0).offset(0)
            $0.right.equalToSuperview().multipliedBy(1.0).offset(0)
        }
        
    }
    
}
extension DestiSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //3항연산으로 filterValue에 값이 있으면 반환, 없으면 items를 반환
        return self.filterCheck ? self.data.filterValue.count : self.data.placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell")!
        
        if self.filterCheck == false {
            cell.textLabel?.text = self.data.placeData[indexPath.row]
        } else {
            cell.textLabel?.text = self.data.filterValue[indexPath.row]
        }
        
        return cell
    }
}

extension DestiSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("테이블뷰 클릭")
        // main에 있는 두번째화면 불러오기(스토리보드 활용)
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "RestaurantViewSB") as! RestaurantViewController
        
        // 다음화면에서 바텀탭 없애기
//        nextView.hidesBottomBarWhenPushed = true
        navigationController!.pushViewController(nextView, animated: true)
        
    }
}

extension DestiSearchViewController: UISearchResultsUpdating {
    // 서치바에서 타이핑시마다 해당 메소드 실행
    func updateSearchResults(for placeSearch: UISearchController) {
        guard let userText = placeSearch.searchBar.text
        else {
            return
        }
        print("사용자 입력 : ", userText )
        self.data.filterValue = self.data.placeData.filter{ $0.localizedCaseInsensitiveContains(userText)}
        self.placeDataTable.reloadData()
    }
}

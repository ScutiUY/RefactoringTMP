//
//  DestiSearchViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/08.
//
import UIKit
import Alamofire

// 검색기능
class DestiSearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource {
    
    lazy var userSearchBar: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "목적지를 입력해주세요"
        // 검색이후 나머지뷰 어둡게?
        searchController.obscuresBackgroundDuringPresentation = false
        
        // searchController를 navi의 searchController에 넣어줘야함
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "목적지 검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
       
        return searchController
    }()
    
    lazy var placeDataTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dataCell")
        
        return tableView
    }()
    
    var data: DestiData = DestiData(place: "")
    
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
        
        view.addSubview(placeDataTable)
    }
    
    func setDelegate() {
        placeDataTable.dataSource = self
        userSearchBar.searchResultsUpdater = self
    }
    
    func setLayout() {
        placeDataTable.snp.makeConstraints {
            $0.top.equalToSuperview().multipliedBy(1.0).offset(0)
            $0.leading.equalToSuperview().multipliedBy(1.0).offset(0)
            $0.bottom.equalToSuperview().multipliedBy(1.0).offset(0)
            $0.right.equalToSuperview().multipliedBy(1.0).offset(0)
        }
        
    }
    
    // delegate 관련 메소드
    // 서치바에서 검색시마다 해당 메소드 실행
    func updateSearchResults(for placeSearch: UISearchController) {
        guard let userText = placeSearch.searchBar.text
        else {
            return
        }
        print("사용자 입력 : ", userText )
        self.data.filterValue = self.data.placeData.filter{ $0.localizedCaseInsensitiveContains(userText)}
        self.placeDataTable.reloadData()
    }
    
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

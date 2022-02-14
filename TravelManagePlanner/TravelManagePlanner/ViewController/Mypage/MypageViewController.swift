//
//  MypageViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/04.
//

import UIKit
import SnapKit

class MypageViewController: UIViewController {
    
    let mypageList = ["개인정보", "환경설정"]
    
    lazy var mypageTableview: UITableView = {
        var tableView = UITableView()
        tableView.register(MypageTableViewCell.self, forCellReuseIdentifier: "myPageCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mypageTableview.delegate = self
        mypageTableview.dataSource = self
        self.title = "My Page".localized
        setLayout()
    }
    
    func setLayout() {
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white

        view.addSubview(mypageTableview)
        
        mypageTableview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

extension MypageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mypageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mypageTableview.dequeueReusableCell(withIdentifier: "myPageCell") as! MypageTableViewCell
        cell.setLayout()
        cell.fetchData(title: mypageList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let personalDataVC = PersonalDataViewController()
        let settingsVC = SettingsViewController()
        
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(personalDataVC, animated: true)
        } else {
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
}

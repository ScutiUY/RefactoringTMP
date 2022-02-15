//
//  SettingsViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/13.
//

import UIKit

class SettingsViewController: UIViewController {

    let settingList = ["Version Information".localized]
    
    lazy var settingsTableview: UITableView = {
        var tableView = UITableView()
        tableView.register(MypageTableViewCell.self, forCellReuseIdentifier: "myPageCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableview.delegate = self
        settingsTableview.dataSource = self
        self.title = "Settings".localized
        setLayout()
    }
    
    func setLayout() {
        
        view.backgroundColor = GlobalConstants.Color.Background.themeColor
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white

        view.addSubview(settingsTableview)
        
        settingsTableview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableview.dequeueReusableCell(withIdentifier: "myPageCell") as! MypageTableViewCell
        cell.setLayout()
        cell.fetchData(title: settingList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let versionInfoVC = VersionInformationViewController()
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(versionInfoVC, animated: true)
        }
    }
    
}

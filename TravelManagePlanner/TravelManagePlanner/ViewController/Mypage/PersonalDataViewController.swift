//
//  personalSetupViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/13.
//

import UIKit

class PersonalDataViewController: UIViewController {

    let personalDataList = ["Change Nickname".localized, "Resign".localized, "Logout".localized]
    
    lazy var personalDataTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(PersonalDataTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personalDataTableView.delegate = self
        personalDataTableView.dataSource = self
        self.title = "Change Nickname".localized
        setLayout()
        // Do any additional setup after loading the view.
    }
    func setLayout() {
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white

        view.addSubview(personalDataTableView)
        
        personalDataTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
extension PersonalDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = personalDataTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonalDataTableViewCell
        cell.setLayout()
        cell.fetchData(title: personalDataList[indexPath.row])
        return cell
    }
    
}

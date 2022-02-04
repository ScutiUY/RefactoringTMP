//
//  JourneyListViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class JourneyListViewController: UIViewController {
    
    var journeyListViewModel: JourneyListViewModel!
    
    lazy var journeyTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(JourneyListTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let activity = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        journeyListViewModel = JourneyListViewModel()
        setObserver()
        setLayout()
        setDelegate()
    }
    
    func setLayout() {
        
        journeyTableView.refreshControl = UIRefreshControl()
        journeyTableView.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        
        self.title = "여행 리스트"
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(journeyTableView)
        view.addSubview(activity)
        
        journeyTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        activity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    func setObserver() {
        journeyListViewModel.loadingStarted = { [weak activity] in
            activity?.isHidden = false
            activity?.startAnimating()
        }
        journeyListViewModel.loadingEnded = { [weak activity] in
            activity?.stopAnimating()
        }
        journeyListViewModel.journeyListUpdated = { [weak self] in
            self?.journeyTableView.reloadData()
            self?.journeyTableView.refreshControl?.endRefreshing()
        }
        journeyListViewModel.getList()
    }
    func setDelegate() {
        journeyTableView.delegate = self
        journeyTableView.dataSource = self
    }
    @objc func onRefresh() {
        journeyListViewModel.getList()
    }
}

extension JourneyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journeyListViewModel.journeyListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journeyTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JourneyListTableViewCell
        let journeyListInfo = journeyListViewModel.journey(index: indexPath.row)
        cell.setLayout()
        cell.setData(journeyListInfo)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailJourneyListVC = UIStoryboard(name: "JourneyListSB", bundle: nil).instantiateViewController(withIdentifier: "JourneyListDetailSB") as! JourneyListDetailViewController
        detailJourneyListVC.title = journeyListViewModel.getTitle(idx: indexPath.row)
        self.navigationController?.pushViewController(detailJourneyListVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

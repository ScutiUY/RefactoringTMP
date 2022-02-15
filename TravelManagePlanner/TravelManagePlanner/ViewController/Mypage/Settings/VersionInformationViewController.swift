//
//  VersionCheckViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/15.
//

import UIKit

class VersionCheckViewController: UIViewController {

    var viewModel = SettingsViewModel()
    
    lazy var versionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.versionCheckLabelSize)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setObserver()
    }
    
    func setLayout() {
        
        self.view.backgroundColor = GlobalConstants.Color.Background.themeColor
        
        view.addSubview(versionLabel)
        
        versionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setObserver() {
        viewModel.dataFetchCompleted.bind { [weak self] in
            if $0 {
                self?.versionLabel.text = "v \(self?.viewModel.getVersionText())"
            }
        }
        viewModel.getVersionData()
    }

}

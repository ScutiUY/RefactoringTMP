//
//  MypageTableViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/04.
//

import UIKit
import SnapKit

class MypageTableViewCell: UITableViewCell {

    lazy var stackview: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var settingImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "setting1")
        return imageView
    }()
    
    lazy var label: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.mainFontSize)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setLayout() {
        
        self.addSubview(stackview)
        stackview.addArrangedSubview(settingImageView)
        stackview.addArrangedSubview(label)
        stackview.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.center.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        settingImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(settingImageView.snp.height)
        }
    }
    
    func fetchData(title: String) {
        label.text = title
    }
}

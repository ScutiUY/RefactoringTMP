//
//  JourneyListTableViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class JourneyListTableViewCell: UITableViewCell {

    lazy var journeyImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var labelAnchorView: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    lazy var journeyTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: GlobalConstants.Font.Size.journeyListTableViewCellTitleSize)
        return label
    }()
    
    lazy var journeyDate: UILabel = {
        var label = UILabel()
        return label
    }()

    override func prepareForReuse() {
        self.journeyImage.image = nil
        
    }
    
    func setLayout() {
        self.contentView.addSubview(journeyImage)
        self.contentView.addSubview(labelAnchorView)
        labelAnchorView.addArrangedSubview(journeyTitleLabel)
        labelAnchorView.addArrangedSubview(journeyDate)
        
        journeyImage.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.9)
            make.width.equalTo(journeyImage.snp.height)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
        labelAnchorView.snp.makeConstraints { make in
            make.top.equalTo(journeyImage.snp.top)
            make.bottom.equalTo(journeyImage.snp.bottom)
            make.leading.equalTo(journeyImage.snp.trailing).offset(10)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-10)
        }
        journeyTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        journeyDate.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    func setData(_ journey: Journey) {
        
        ImageLoader.shard.loadImage(url: journey.imgUrl) { [weak self] result in
            switch result {
            case .success(let image):
                self?.journeyImage.image = image
            case .failure(let error):
                print(error)
            }
        }
        self.journeyTitleLabel.text = journey.title
        self.journeyDate.text = journey.sDate + " - " + journey.eDate
    }
}

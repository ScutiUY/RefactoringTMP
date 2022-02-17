//
//  CommunityCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/10.
//

import UIKit
import Then
import SnapKit

class CommunityCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var communityViewModel: CommunityViewModel!
    
    lazy var communityCollectionViewImage = UIImageView().then {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
        $0.backgroundColor = .lightGray
    }
    
    lazy var communityCollectionViewTitle = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 20)
        $0.backgroundColor = GlobalConstants.Color.Background.themeColor
    }
    
    lazy var communityCollectionViewHashtags = UILabel().then {
        $0.textColor = .gray
        $0.font = .boldSystemFont(ofSize: 12)
        $0.backgroundColor = GlobalConstants.Color.Background.themeColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = GlobalConstants.Color.Background.themeColor
        communityViewModel = CommunityViewModel()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    
    // MARK: functions
    private func setLayout() {
        self.addSubview(communityCollectionViewImage)
        self.addSubview(communityCollectionViewTitle)
        self.addSubview(communityCollectionViewHashtags)
        
        communityCollectionViewImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalTo(self.snp.centerX)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        communityCollectionViewTitle.snp.makeConstraints {
            $0.top.equalTo(communityCollectionViewImage.snp.bottom).offset(10)
            $0.centerX.equalTo(self.snp.centerX)
            $0.width.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        communityCollectionViewHashtags.snp.makeConstraints {
            $0.top.equalTo(communityCollectionViewTitle.snp.bottom)
            $0.centerX.equalTo(self.snp.centerX)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(20)
        }
    }
    
    func setData(_ communityDataDetail: CommunityData.CommunityDataDetail) {
        ImageLoader.loadImage(url: communityDataDetail.imgUrl) { [weak self] image in
                self?.communityCollectionViewImage.image = image
            }
        self.communityCollectionViewTitle.text = communityDataDetail.title
            self.communityCollectionViewHashtags.text = communityDataDetail.tags
    }
}

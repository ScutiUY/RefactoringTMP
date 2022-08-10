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
    
    lazy var imageShadowView = UIView().then {
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowRadius = 5
        $0.layer.shadowColor = UIColor.gray.cgColor
    }
    
    lazy var communityCollectionViewImage = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        communityCollectionViewImage.image = nil
        communityCollectionViewTitle.text = ""
        communityCollectionViewHashtags.text = ""
        self.layer.borderColor = .none
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
        self.addSubview(imageShadowView)
        imageShadowView.addSubview(communityCollectionViewImage)
        self.addSubview(communityCollectionViewTitle)
        self.addSubview(communityCollectionViewHashtags)
        
        imageShadowView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalTo(self.snp.centerX)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        communityCollectionViewImage.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalToSuperview()
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
        ImageLoader.shard.loadImage(url: communityDataDetail.imgUrl) { [weak self] result in
            switch result {
            case .success(let image):
                self?.communityCollectionViewImage.image = image
            case .failure(let error):
                print(error)
            }
        }
        self.communityCollectionViewTitle.text = communityDataDetail.title
        self.communityCollectionViewHashtags.text = communityDataDetail.tags
    }
}

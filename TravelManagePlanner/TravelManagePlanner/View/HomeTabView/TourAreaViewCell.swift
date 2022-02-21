//
//  TourAreaViewCell.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//

import UIKit

class TourAreaViewCell: UITableViewCell {
    
    var cellDelegate: ContentsMainTextDelegate?
    
    lazy var place:String = ""
    lazy var sIdx: Int = 0
    
    lazy var tourAreaImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // 이미지 잘려도 꽉채우기 설정
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.3
        
        
        return imageView
    }()
    
    lazy var tourAreaTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    lazy var tourAreaSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    lazy var tourAreaSelectButton: UIButton = {
        let  button = UIButton()
        button.setImage(UIImage(named: "selectIcon"), for: .normal) // You can set image direct from Storyboard
        button.setImageTintColor(GlobalConstants.Color.IconColor.recommendSelectButtonColor)
        button.backgroundColor = .clear
        
        return button
    }()
    
    
    @objc
    func tourAreaSelectAction() {
        cellDelegate?.categoryButtonTapped(title: tourAreaTitle.text ?? "", place: self.place, sIdx: self.sIdx)
    }
    
    lazy var tourAreaTitleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tourAreaTitle, tourAreaSubTitle])
        stackView.axis = .vertical
        stackView.spacing = 3
        
        return stackView
    }()
    
    lazy var tourAreaAllTitleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tourAreaTitleStack, tourAreaSelectButton])
        stackView.axis = .horizontal
        stackView.spacing = 215
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setLayout()
        
        self.tourAreaSelectButton.addTarget(self, action: #selector(tourAreaSelectAction), for: .touchUpInside)
        
        
    }
    
    func setUpView() {
        contentView.addSubview(tourAreaImg)
        contentView.addSubview(tourAreaAllTitleStack)
        
    }
    
    func setLayout() {
        tourAreaImg.snp.makeConstraints {
            $0.top.equalToSuperview().multipliedBy(1.1)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-80)
        }
        
        tourAreaAllTitleStack.snp.makeConstraints {
            $0.top.equalTo(tourAreaImg.snp.bottom).multipliedBy(1.0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

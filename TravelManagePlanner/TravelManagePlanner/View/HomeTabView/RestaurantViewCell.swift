//
//  RestaurantViewCell.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//
import UIKit

class RestaurantViewCell: UITableViewCell {

    var cellDelegate: ContentsMainTextDelegate?
        
    // 디테일 캘린더로 전달할 데이터
    lazy var place:String = ""
    lazy var sIdx: Int = 0
    
    lazy var restaurantImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.3
        
        return imageView
    }()
        
        lazy var restaurantTitle: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 22)
            label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
            
            return label
        }()
        
        lazy var restaurantSubTitle: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
            
            return label
        }()
        
        lazy var restaurantSelectButton: UIButton = {
           let  button = UIButton()
            button.setTitle("선택", for: .normal)
            button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 1), for: .normal)
            button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 0.6), for: .highlighted)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
            button.backgroundColor = .clear
            
            return button
        }()
        
        @objc
        func restaurantSelectAction() {
            cellDelegate?.categoryButtonTapped(title: restaurantTitle.text ?? "", place: self.place, sIdx: self.sIdx)
        }
        
        lazy var restaurantTitleStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [restaurantTitle, restaurantSubTitle])
            stackView.axis = .vertical
            stackView.spacing = 3
            
            return stackView
        }()
        
        lazy var restaurantAllTitleStack: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [restaurantTitleStack, restaurantSelectButton])
            stackView.axis = .horizontal
            stackView.spacing = 200
            
            return stackView
        }()
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setUpView()
            setLayout()
            
            self.restaurantSelectButton.addTarget(self, action: #selector(restaurantSelectAction), for: .touchUpInside)
            
            
        }
        
        func setUpView() {
            contentView.addSubview(restaurantImg)
            contentView.addSubview(restaurantAllTitleStack)
            
        }
        
        func setLayout() {
//            restaurantImg.frame = CGRect.init(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height / 0.28)
            restaurantImg.frame = CGRect.init(x: 0, y: 0, width: 347.0, height: 160.0) //추후 오토레이아웃 변경필요
            
            restaurantAllTitleStack.snp.makeConstraints {
                $0.top.equalTo(restaurantImg.snp.bottom).multipliedBy(1.0)
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

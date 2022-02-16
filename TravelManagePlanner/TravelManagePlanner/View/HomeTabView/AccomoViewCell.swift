//
//  AccomoViewCell.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/24.
//
import UIKit

class AccomoViewCell: UITableViewCell {
        
    var cellDelegate: ContentsMainTextDelegate?
    
    // 디테일 캘린더로 전달할 데이터
    lazy var place:String = ""
    lazy var sIdx: Int = 0
    
    lazy var accomoImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
//        imageView.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.3
        
        return imageView
    }()
    
    lazy var accomoTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    lazy var accomoSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
        
        return label
    }()
    
    lazy var accomoSelectButton: UIButton = {
       let  button = UIButton()
        button.setTitle("선택", for: .normal)
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 209/255, green: 120/255, blue: 168/255, alpha: 0.6), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = .clear
        
        return button
    }()
    
    
    @objc
    func accomoSelectAction() {
        cellDelegate?.categoryButtonTapped(title: accomoTitle.text ?? "", place: self.place, sIdx: self.sIdx)
    }
    
    lazy var accomoTitleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accomoTitle, accomoSubTitle])
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    lazy var accomoAllTitleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accomoTitleStack, accomoSelectButton])
        stackView.axis = .horizontal
//        stackView.spacing = 30
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setLayout()
        
        self.accomoSelectButton.addTarget(self, action: #selector(accomoSelectAction), for: .touchUpInside)
    }
    
    func setUpView() {
        contentView.addSubview(accomoImg)
        contentView.addSubview(accomoAllTitleStack)
        
    }
    
    func setLayout() {
//        accomoImg.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: contentView.frame.height / 0.3)
        accomoImg.frame = CGRect.init(x: 0, y: 0, width: 347.0, height: 160.0)
        
        accomoAllTitleStack.snp.makeConstraints {
            $0.top.equalTo(accomoImg.snp.bottom).multipliedBy(1.0)
            $0.leading.equalToSuperview().inset(0)
            $0.trailing.equalToSuperview().inset(0)
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

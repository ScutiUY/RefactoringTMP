//
//  AccomoViewCell.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/24.
//

import UIKit

class AccomoViewCell: UITableViewCell {
    
    lazy var accomoImgButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    lazy var accomoTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
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
    
    lazy var accomoTitleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accomoTitle, accomoSubTitle])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var accomoAllStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accomoImgButton, accomoTitleStack])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
 
    // 함수생성후 뷰컨에서 호출 이미지를 뷰컨에서 넘겨줌
    func cellLoadImage(_ imgData: String) {
        
        accomoImgButton.setImage(UIImage(named: imgData), for: .normal)
        accomoImgButton.imageView?.layer.cornerRadius = 15
        accomoImgButton.layer.shadowColor = UIColor.black.cgColor
        accomoImgButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        accomoImgButton.layer.shadowRadius = 5
        accomoImgButton.layer.shadowOpacity = 0.3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setLayout()
    }
    
    func setUpView() {
        addSubview(accomoAllStack)
        //        addSubview(imgLabel)
    }
    
    func setLayout() {
        accomoAllStack.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setUpView()
//        setLayout()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

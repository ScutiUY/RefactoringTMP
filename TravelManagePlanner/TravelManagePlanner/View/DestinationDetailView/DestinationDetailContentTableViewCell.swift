//
//  JourneyDetailContentTableViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/18.
//

import UIKit
import SnapKit

class DestinationDetailContentTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        var title = UILabel()
        title.font = UIFont.systemFont(ofSize: 40)
        title.textColor = .black
        return title
    }()
    lazy var contentTextView: UITextView = {
        var textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 30)
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLayout() {
        self.addSubview(titleLabel)
        self.addSubview(contentTextView)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    func fetchDestInfo(data: DestinationDetailData.DestinationData) {
        titleLabel.text = data.name
        contentTextView.text = data.content
    }
    

}

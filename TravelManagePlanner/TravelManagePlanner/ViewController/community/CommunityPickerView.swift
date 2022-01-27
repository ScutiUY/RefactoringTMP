//
//  communityPickerView.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/06.
//

import UIKit

var list = ["연인", "가족", "친구", "기타"]

class CommunityPickerViewClass: UIPickerView {
    
    // MARK: - Init
    init(mainViewController: UIViewController)
    {
        self.mainViewController = mainViewController
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    let mainViewController : UIViewController

    lazy var pickerToolbar : UIToolbar = {
        let toolbar = UIToolbar()
        let btnDone = UIBarButtonItem()
        let space = UIBarButtonItem()
        let btnCancel = UIBarButtonItem()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.backgroundColor = .lightGray
        toolbar.sizeToFit()
        toolbar.setItems([btnCancel , space , btnDone], animated: true)
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }()
    
    lazy var communityPickerView : UIPickerView = {
        let picker = UIPickerView()
        picker.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        return picker
    }()

}

//
//  LoginButton.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/02.
//

import UIKit

class LoadingButton: UIButton {
    
    private let indicator   = UIActivityIndicatorView(style: .large)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        makeIndicator()
    
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        makeIndicator()
    }
    private func setupButton() {
        layer.borderWidth   = 0.5
        layer.borderColor   = UIColor.darkGray.cgColor
        layer.cornerRadius  = 5
        backgroundColor = UIColor.white
    }
    
    private func makeIndicator() {
        self.addSubview(indicator)

        indicator.snp.makeConstraints { (m) in
            m.centerX.equalTo(self.snp.centerX)
            m.centerY.equalTo(self.snp.centerY)
        }
        
    }
    
    public func startIndicator() {
        self.setTitleColor(self.titleLabel?.textColor.withAlphaComponent(0), for: .normal)
        indicator.startAnimating()
        indicator.isUserInteractionEnabled = false
    }
    public func stopIndicator() {
        self.setTitleColor(self.titleLabel?.textColor.withAlphaComponent(1), for: .normal)
        indicator.stopAnimating()
    }
    
}

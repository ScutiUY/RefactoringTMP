//
//  JourneyDetailListCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class JourneyListDetailPageCollectionView: UICollectionViewCell {
    
    private lazy var journeyListDetailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(JourneyListDetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        journeyListDetailCollectionView.delegate = self
        journeyListDetailCollectionView.dataSource = self
        self.addSubview(journeyListDetailCollectionView)
        journeyListDetailCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
extension JourneyListDetailPageCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = journeyListDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JourneyListDetailCollectionViewCell
        cell.backgroundColor = .blue
        return cell
    }
    
    
}


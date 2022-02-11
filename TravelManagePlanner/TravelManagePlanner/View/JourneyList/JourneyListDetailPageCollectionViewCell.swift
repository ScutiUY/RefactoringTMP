//
//  JourneyDetailListCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

protocol passDestinationData {
    
}

class JourneyListDetailPageCollectionView: UICollectionViewCell {
    
    var viewModel = JourneyListDetailPageViewModel()
    
    var parentViewSize = CGSize(width: 0, height: 0)
    
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
        return viewModel.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = journeyListDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JourneyListDetailCollectionViewCell
        cell.setLayout()
        cell.titleLabel.text = viewModel.journey(idx: indexPath.row).name
        cell.descLabel.text = viewModel.journey(idx: indexPath.row).content
        cell.thumNailImage.image = viewModel.getImage()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationDetailVC = UIStoryboard(name: "DestinationDetailSB", bundle: nil).instantiateViewController(withIdentifier: "DestinationDetailSB") as! DestinationDetailViewController
        
    }
    
}

extension JourneyListDetailPageCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: parentViewSize.width * 0.9, height: 150)
    }
}


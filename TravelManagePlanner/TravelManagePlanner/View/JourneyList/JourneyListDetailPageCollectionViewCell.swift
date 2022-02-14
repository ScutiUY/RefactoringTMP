//
//  JourneyDetailListCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

protocol PassDestinationData {
    func journeyListDetailCV(destinationIdx: Int)
}

class JourneyListDetailPageCollectionView: UICollectionViewCell {
    var delegate: PassDestinationData!
    var viewModel = JourneyListDetailPageViewModel()
    
    var parentViewSize = CGSize(width: 0, height: 0)
    
    private lazy var journeyListDetailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(JourneyListDetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        //collectionView.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setObserver()
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
    func setObserver() {
        viewModel.loadingStarted = {
            
        }
        viewModel.loadingEnded = {
            
        }
        viewModel.dataUpdated = {
            self.journeyListDetailCollectionView.reloadData()
        }
    }
    
}

extension JourneyListDetailPageCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.categoriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countInSectionItems(idx: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = journeyListDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JourneyListDetailCollectionViewCell
        cell.setLayout()
        cell.titleLabel.text = viewModel.journey(idx: indexPath.row).name
        cell.descLabel.text = viewModel.journey(idx: indexPath.row).content
        cell.thumNailImage.image = viewModel.getImage()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { // 선택시 delegate를 통해  JourneyListDetailViewController로 destination idx를 넘긴다
        
        delegate.journeyListDetailCV(destinationIdx: viewModel.destination(idx: indexPath.row))
    }
    
}

extension JourneyListDetailPageCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: parentViewSize.width * 0.9, height: 150)
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView { // 섹션 헤더 
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
}


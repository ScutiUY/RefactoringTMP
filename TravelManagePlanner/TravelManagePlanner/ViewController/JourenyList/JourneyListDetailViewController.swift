//
//  JourneyListDetailViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class JourneyListDetailViewController: UIViewController {

    var viewModel = JourneyListDetailViewModel()
    
    private lazy var journeyListDetailDateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(JourneyListDetailDateCollectionViewCell.self, forCellWithReuseIdentifier: "dateCell")
        return collectionView
    }()
    
    private lazy var journeyListDetailPageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(JourneyListDetailPageCollectionView.self, forCellWithReuseIdentifier: "pageCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObserver()
        setLayout()
        setDelegate()
    }
    
    private func setLayout() {
        view.addSubview(journeyListDetailDateCollectionView)
        view.addSubview(journeyListDetailPageCollectionView)
        
        journeyListDetailDateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(30)
        }
        journeyListDetailPageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(journeyListDetailDateCollectionView.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    private func setDelegate() {
        // ?????? ????????????
        journeyListDetailDateCollectionView.delegate = self
        journeyListDetailDateCollectionView.dataSource = self
        // ????????? ????????????
        journeyListDetailPageCollectionView.delegate = self
        journeyListDetailPageCollectionView.dataSource = self
        viewModel.getData()
    }
    private func setObserver() {
        viewModel.loadingStarted = {
            
        }
        viewModel.loadingEnded = {
            
        }
        viewModel.dataUpdated = {
            self.journeyListDetailDateCollectionView.reloadData()
            self.journeyListDetailPageCollectionView.reloadData()
        }
        viewModel.getData()
    }
}
extension JourneyListDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { // ????????? ?????? ??????
        return viewModel.dateCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        ///dateCollectionView ?????? ????????? ????????? ?????? collectionView
        ///VM?????? journeyDetailList: [JourneyDetailData]??? dataDic??? ???????????? ????????? cell??? ?????? ???????????????
        if collectionView == journeyListDetailDateCollectionView {
            
            guard let cell = journeyListDetailDateCollectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as? JourneyListDetailDateCollectionViewCell else { fatalError() }
            cell.setLayout()
            cell.setLabelName(name: viewModel.journey(idx: indexPath.row).visitDate)
            
            if indexPath.row == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
            return cell
            
            
        } else {
            /// ????????? ????????? ?????? pageCollectionView - ????????? ???????????? ??? collectionView?????? detailCollectionView??? ??????
            /// ?????? ????????? ?????? ???????????? datailCollectionView??? ??????
            /// ?????? ????????? ????????? ????????? ????????? ?????? ???????????? ????????? detailCollectionView?????? ??????
            
            guard let cell = journeyListDetailPageCollectionView.dequeueReusableCell(withReuseIdentifier: "pageCell", for: indexPath) as? JourneyListDetailPageCollectionView else { fatalError() }
            cell.delegate = self
            cell.parentViewSize = CGSize(width: view.frame.width, height: collectionView.frame.height)
            
            
            // ?????? index ????????? ?????? ?????? ?????? ???????????? ?????? ????????? ?????????
            cell.viewModel.getList(journeyDetailDataFromPageCollectionView: viewModel.passJourneyInfoInDate(index: indexPath.row))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // collectionView ??? ?????????
        if collectionView == journeyListDetailDateCollectionView {
            return CGSize(width: 80, height: 15)
        } else {
            return CGSize(width: view.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { // item ?????????
        if collectionView == journeyListDetailDateCollectionView {
            journeyListDetailPageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension JourneyListDetailViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == journeyListDetailPageCollectionView {
            let currentIdx = Int(scrollView.contentOffset.x / view.frame.width)
            journeyListDetailDateCollectionView.selectItem(at: IndexPath(item: currentIdx, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }

}

extension JourneyListDetailViewController: PassDestinationData {
    func journeyListDetailCV(destinationIdx: Int) {
        
        guard let destinationDetailVC = UIStoryboard(name: "DestinationDetailSB", bundle: nil).instantiateViewController(withIdentifier: "DestinationDetailSB") as? DestinationDetailViewController else { fatalError() }
        destinationDetailVC.destinationDetailViewModel.shopId = String(destinationIdx)
        destinationDetailVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(destinationDetailVC, animated: true)
    }
}

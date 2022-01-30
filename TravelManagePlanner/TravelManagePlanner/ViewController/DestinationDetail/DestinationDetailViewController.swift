//
//  DetailViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class DestinationDetailViewController: UIViewController {
    
    var destinationDetailViewModel: DestinationDetailViewModel!
    
    let images: [UIImage] = [UIImage(named: "Seoul1")!, UIImage(named: "Seoul2")!, UIImage(named: "Seoul3")!, UIImage(named: "Seoul4")!]
    
    lazy var imageAnchorView: UIView = {
        var view = UIView()
        return view
    }()
    
    lazy var imageSliderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageSliderCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    lazy var imagePageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.currentPage = 0
        return pageControl
    }()
    
    lazy var destinationDetailContentTableView: UITableView = {
        var tableView = UITableView()
        tableView.allowsSelection = false
        tableView.register(DestinationDetailContentTableViewCell.self, forCellReuseIdentifier: "JDCcell")
        tableView.register(DestinationDetailContentTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationDetailViewModel = DestinationDetailViewModel()
        destinationDetailViewModel.getDestinationData()
        setLayout()
        setDelegate()
        // Do any additional setup after loading the view.
    }
    
    func setLayout() {
        view.addSubview(imageAnchorView)
        imageAnchorView.addSubview(imageSliderCollectionView)
        imageAnchorView.addSubview(imagePageControl)
        
        view.addSubview(destinationDetailContentTableView)
        
        imageAnchorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.width.equalToSuperview()
        }
        imageSliderCollectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(imageAnchorView.snp.width)
            make.height.equalTo(imageSliderCollectionView.snp.width).multipliedBy(0.8)
        }
        imagePageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        destinationDetailContentTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.bottom.equalTo(view.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            
        }
        
    }
    
    func setDelegate(){
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.dataSource = self
        destinationDetailContentTableView.delegate = self
        destinationDetailContentTableView.dataSource = self
    }
    
}
extension DestinationDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagePageControl.numberOfPages = images.count
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageSliderCollectionViewCell
        let image = images[indexPath.row]
        cell.setCollectionViewIngredient(image: image)
        return cell
    }
    
}
extension DestinationDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return imageSliderCollectionView.frame.size
    }
    
}
extension DestinationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = destinationDetailContentTableView.dequeueReusableCell(withIdentifier: "JDCcell", for: indexPath) as! DestinationDetailContentTableViewCell
        cell.setLayout()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}

extension DestinationDetailViewController { // scrollview
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let idx = imageSliderCollectionView.visibleCells.last!
        imagePageControl.currentPage = imageSliderCollectionView.indexPath(for: idx)!.row
    }
    
}

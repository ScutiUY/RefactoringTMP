//
//  DetailViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    let images: [UIImage] = [UIImage(named: "Seoul1")!, UIImage(named: "Seoul2")!, UIImage(named: "Seoul3")!, UIImage(named: "Seoul4")!]
    
    lazy var detailScrollView: UIScrollView = {
        var scrollView = UIScrollView()
        return scrollView
    }()
    
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
    
    lazy var contentTableView: UITableView = {
        var tableView = UITableView()
        return tableView
    }()
    
    lazy var imagePageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.currentPage = 0
        return pageControl
    }()
    
    lazy var contentAnchorView: UIView = {
        var view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Sample"
        return label
    }()
    lazy var descTextView: UITextView = {
        var textView = UITextView()
        textView.text = "Sample"
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setDelegate()
        // Do any additional setup after loading the view.
    }
    
    func setLayout() {
        view.addSubview(imageAnchorView)
        imageAnchorView.addSubview(imageSliderCollectionView)
        imageAnchorView.addSubview(imagePageControl)
        
        view.addSubview(contentAnchorView)
        
        imageAnchorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.snp.centerY)
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
        
        contentAnchorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.45)
        }
    }
    
    func setDelegate(){
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.dataSource = self
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
}
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = imageSliderCollectionView.indexPathsForVisibleItems.first {
            imagePageControl.currentPage = indexPath.row
        }
    }
}
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return imageSliderCollectionView.frame.size
    }
    
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}

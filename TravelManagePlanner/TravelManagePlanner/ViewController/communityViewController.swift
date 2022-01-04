//
//  ViewController.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import UIKit
import SnapKit
import JJFloatingActionButton


let cellID = "Cell"

//MARK: - PickerView
class communityPickerView: UIPickerView {

//    self.back
}

//MARK: - Main ViewController
class communityViewController: UIViewController {
    // MARK: - Properties
    
    lazy var communityCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        return cv
    }()
//
//    lazy var communityCollectionViewCellImage : UIImage = {
//
//    }()
//
//    lazy var communityCollectionViewCellHashTag : UITextView = {
//
//    }()

    
    // MARK: - UISearchBar (따로 분리 예정)
    lazy var communitySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "여행지를 입력해주세요."
        searchBar.backgroundImage = UIImage() // searchBar 테두리 없애는 편법
        searchBar.setImage(UIImage(named: "icCaencel"), for: .clear, state: .normal)
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.frame.size.height = 1
            textfield.backgroundColor = UIColor.white
            textfield.layer.cornerRadius = 15.0
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textfield.textColor = UIColor.black
            
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트 정하기
                rightView.tintColor = UIColor.white
            }
        }
        return searchBar
    }()
    
    // MARK: - JJFloatingButton
    lazy var comminityFloatingButton : JJFloatingActionButton = {
        let actionButton = JJFloatingActionButton()
        let alert = UIAlertController()
        let defaultAction = UIAlertAction(title: "OK", style: .default , handler: nil)
        
        alert.title = "You Clicked!"
        alert.addAction(defaultAction)
        
        actionButton.buttonColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        actionButton.addItem(title: "북마크 리뷰", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate)) { item in
            alert.message = "\(item.titleLabel.text!)"
            self.present(alert, animated: true)
        }

        actionButton.addItem(title: "내가 작성한 리뷰", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)) { item in
            alert.message = "\(item.titleLabel.text!)"
            self.present(alert, animated: true, completion: nil)
        }

        actionButton.addItem(title: "리뷰 작성하기", image: nil) { item in
            alert.message = "\(item.titleLabel.text!)"
            self.present(alert, animated: true, completion: nil)
        }
        return actionButton
    }()
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityCollectionView.dataSource = self
        communityCollectionView.delegate = self
        view.backgroundColor = .blue
        setCollectionView()
        communityCollectionView.register(DemoCell.self, forCellWithReuseIdentifier: cellID)
        
       

        view.addSubview(comminityFloatingButton)
        comminityFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        comminityFloatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        comminityFloatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    
    // MARK: - AutoLayout(SnapKit)
    func setCollectionView() {
        
        view.addSubview(communityCollectionView)
        view.addSubview(communitySearchBar)
        
        communitySearchBar.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.55)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            
        }
        communityCollectionView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.9)
            make.top.equalTo(communitySearchBar.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


extension communityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DemoCell
        
        cell.backgroundColor = .red
        return cell
    }
    
    
}

extension communityViewController: UICollectionViewDelegate {
    
}


extension communityViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4 , height: communityCollectionView.frame.height / 3)
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    }
}

//
//extension communityViewController : UIPickerViewDelegate, UIPickerViewDataSource {
//
//}

//
//  EXViewController.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/27.


import UIKit
import SnapKit
import Then
import JJFloatingActionButton

let communityFloatingButton = CommunityFloatingButtonClass().communityFloatingButton
let cellId: String = "Cell"
let commuinityCategorydata = ["전체", "연인", "가족", "친구", "기타"]
let themeColor = GlobalConstants.Color.Background.themeColor

class CommunityViewController: UIViewController {
    
    // MARK: - Properties
    var communityViewModel: CommunityViewModel!
    lazy var communityNavigationBar = CommunityCustomNavigationView()
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let activity = UIActivityIndicatorView()
    
    lazy var communityCategorytextField = UITextField().then({
        $0.text = " 전체"
        $0.contentVerticalAlignment = .center
        $0.tintColor = .clear
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
    })
        
    let communityCategoryPickerView = UIPickerView()
    let communityCategoryToolBarSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let communityCategoryToolBarButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
    
    lazy var communityCategoryToolBar : UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 40)
        toolbar.backgroundColor = .darkGray
        toolbar.setItems([communityCategoryToolBarSpace, communityCategoryToolBarButton], animated: true)
        return toolbar
    }()
    
    lazy var communityCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        cv.backgroundColor = themeColor
        cv.register(CommunityCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()

    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = themeColor
        communityFloatingButton.items[0].addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
        communityCollectionView.dataSource = self
        communityCollectionView.delegate = self
        communityFloatingButton.delegate = self
        communityViewModel = CommunityViewModel()
        setObserver()
    
        view.addSubview(activity)

        activity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        setNav()
        setCollectionView()
        setFloatingButton()
    }
    
    
    // MARK: - Methods
    
    // 커스텀 커뮤니티 네비게이션바
    func setNav() {
        
        view.addSubview(communityNavigationBar)
        communityNavigationBar.layer.shadowColor = UIColor.black.cgColor
        communityNavigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        communityNavigationBar.layer.shadowOpacity = 0.1
        communityCategoryPickerView.delegate = self
        self.communityNavigationBar.NavTheme.inputView = communityCategoryPickerView
        self.communityNavigationBar.NavTheme.inputAccessoryView = communityCategoryToolBar
        communityNavigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.16)
        }
    }
    
    func setObserver() {
        communityViewModel.loadingStarted = { [weak activity] in
            activity?.isHidden = false
            activity?.startAnimating()
        }
        communityViewModel.loadingEnded = { [weak activity] in
            activity?.stopAnimating()
        }
        communityViewModel.communityUpdated = { [weak self] in
            self?.communityCollectionView.reloadData()
            self?.communityCollectionView.refreshControl?.endRefreshing()
        }
        communityViewModel.getList()
    }

    func setCollectionView() {
        
        view.addSubview(communityCollectionView)

        communityCollectionView.snp.makeConstraints {
            $0.top.equalTo(communityNavigationBar.snp.bottom).offset(10) // 수정
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setFloatingButton() {
        view.addSubview(communityFloatingButton)
        
        communityFloatingButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    @objc func onPickDone() {
        communityNavigationBar.NavTheme.resignFirstResponder()
     }

    
    @objc func ButtonPressed(_: UIButton)
    {
        let reviewVC = ReviewWriteViewController()
        self.navigationController!.pushViewController(reviewVC, animated: true)
    }

    @objc func onRefresh() {
        communityViewModel.getList()
    }
}

// MARK: - extensions

extension CommunityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return communityViewModel.communityDataListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommunityCollectionViewCell
        let communityDataInfo = communityViewModel.community(index: indexPath.row)
        cell.backgroundColor = themeColor
        cell.setData(communityDataInfo)
        return cell
    }
    
    
}

extension CommunityViewController: UICollectionViewDelegate {
    
}


extension CommunityViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = communityCollectionView.frame.width
        let height = communityCollectionView.frame.height
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 3
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
}

// MARK: - Picker 관련
extension CommunityViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return commuinityCategorydata.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        communityNavigationBar.NavTheme.text = "\(commuinityCategorydata[row])"
        communityNavigationBar.NavTheme.sizeToFit()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return commuinityCategorydata[row]
    }
}

// MARK: - TextField 왼쪽 공백 없애기
extension UITextField {
    func addLeftPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
    }
}

// MARK: - FloatingButton 관련
extension CommunityViewController : JJFloatingActionButtonDelegate
{
    func floatingActionButtonWillOpen(_ button: JJFloatingActionButton) {
        communityFloatingButton.buttonColor = .white
        communityFloatingButton.buttonImageColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
    }
    func floatingActionButtonWillClose(_ button: JJFloatingActionButton) {
        communityFloatingButton.buttonColor =  #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        communityFloatingButton.buttonImageColor = .white
    }
}

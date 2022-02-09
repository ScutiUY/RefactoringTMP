//
//  EXViewController.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/27.


import UIKit
import SnapKit
import JJFloatingActionButton

let communityFloatingButton = CommunityFloatingButtonClass().communityFloatingButton
let communitySearchBar = CommunitySearchBarClass().communitySearchBar
let cellId: String = "Cell"
let commuinityCategorydata = ["전체", "연인", "가족", "친구", "기타"]

class CommunityViewController: UIViewController {
    // MARK: - Properties
    
    var communityViewModel: CommunityViewModel!
    
    let activity = UIActivityIndicatorView()
    
    lazy var communityCategorytextField : UITextField = {
        let textfield = UITextField()
        textfield.text = " 전체"
        textfield.contentVerticalAlignment = .center
        textfield.tintColor = .clear
        textfield.layer.cornerRadius = 10
        textfield.backgroundColor = .white
        textfield.layer.shadowColor = UIColor.black.cgColor
        textfield.layer.shadowOffset = CGSize(width: 0, height: 4)
        textfield.layer.shadowRadius = 5
        textfield.layer.shadowOpacity = 0.2
        return textfield
    }()
        
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
        cv.backgroundColor = UIColor(red: 243/255, green: 255/255, blue: 251/255, alpha: 1)
        cv.register(DemoCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()

//    lazy var communityCollectionViewCellImage : UIImage = {
//
//    }()

//    lazy var communityCollectionViewCellHashTag : UITextView = {
//
//    }()

    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 243/255, green: 255/255, blue: 251/255, alpha: 1)
        communityFloatingButton.items[0].addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
        communityCollectionView.dataSource = self
        communityCollectionView.delegate = self
        communityFloatingButton.delegate = self
        setCollectionView()
//        setCommunityPickerView()
        setFloatingButton()
        setNav()
        communityViewModel = CommunityViewModel()
        setObserver()
    
        view.addSubview(activity)

        activity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    
    // MARK: - Methods
    
    
    func setNav() {
        

        
        
//        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//        self.navigationItem.searchController = searchController
        self.navigationItem.title = "커뮤니티"

        searchBar.placeholder = "여행지를 입력하세요."
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.shadowColor = UIColor.black.cgColor
        searchBar.searchTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchBar.searchTextField.layer.shadowRadius = 3
        searchBar.searchTextField.layer.shadowOpacity = 0.1
        searchBar.setImage(UIImage(named: "icCaencel"), for: .clear, state: .normal)
        searchBar.layer.cornerRadius = 30
//        hidesNavigationBarDuringPresentation = false
        searchBar.showsCancelButton = false
        self.navigationItem.titleView = searchBar
//        self.navigationItem.titleView?.frame
        
        
        
        
        
        
        // Appearance에 저장을 해야 navigationbar 모두에 적용된다.
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = GlobalConstants.Color.Background.themeColor
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        

        

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
    
    
    
    
    
    
    
    
    
    
    
    
//    func setCommunityPickerView()
//    {
//        view.addSubview(communityCategorytextField)
//        communityCategorytextField.addLeftPadding()
//
//        communityCategorytextField.snp.makeConstraints { make in
//            make.trailing.equalTo(communitySearchBar.snp.trailing).offset(100)
//            make.top.equalTo(communitySearchBar.snp.top).offset(10)
//            make.width.equalTo(communitySearchBar).multipliedBy(0.3)
//            make.height.equalTo(communitySearchBar).multipliedBy(0.6)
//        }
//        communityCategoryPickerView.delegate = self
//        self.communityCategorytextField.inputView = communityCategoryPickerView
//        self.communityCategorytextField.inputAccessoryView = communityCategoryToolBar
//    }
//
    
    
    func setCollectionView() {
        
        view.addSubview(communityCollectionView)
//        view.addSubview(communitySearchBar)
//
//        communitySearchBar.snp.makeConstraints { make in
//            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.55)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
//
//        }
        communityCollectionView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.9)
            make.top.equalTo(view.snp.top).offset(20) // 수정
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
        communityCategorytextField.resignFirstResponder()
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
        return communityViewModel.communityDataListCount() + 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DemoCell
        
        cell.backgroundColor = .red
        return cell
    }
    
    
}

extension CommunityViewController: UICollectionViewDelegate {
    
}


extension CommunityViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4 , height: communityCollectionView.frame.height / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    }
}

extension CommunityViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return commuinityCategorydata.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        communityCategorytextField.text = "\(commuinityCategorydata[row])"
        communityCategorytextField.sizeToFit()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return commuinityCategorydata[row]
    }
}

extension UITextField {
    func addLeftPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
    }
}

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

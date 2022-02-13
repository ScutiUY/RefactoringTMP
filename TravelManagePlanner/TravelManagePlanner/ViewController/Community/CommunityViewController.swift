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

    let activity = UIActivityIndicatorView()
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var filterTheme : String = ""
    
    lazy var communityNavigationBar = CommunityCustomNavigationView()
    private var journeyList = JourneyList.shared.data

    let communityCategoryPickerView = UIPickerView()
    let communityCategoryToolBarSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let communityCategoryToolBarButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(themeFiltering))
    
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
//    // 키보드나 pickerview올라가 있을 시, 다른 곳을 누르면 내려가게 해주는 것
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = themeColor
        communityViewModel = CommunityViewModel()
        getJourneyData()
        setDelegate()
        setRefresh()
        setNav()
        setCollectionView()
        setObserver()
        setFloatingButton()
    }
    
    
    // MARK: - Methods
    func getJourneyData() {
        JourneyListRepository().getJourneyList(completed: { result in
            self.journeyList = result
        })
    }
    func setDelegate() {
        communityNavigationBar.NavSearchBar.delegate = self
        communityCollectionView.dataSource = self
        communityCollectionView.delegate = self
        communityFloatingButton.delegate = self
    }
    
    // 새로고침 인디케이터
    func setRefresh() {
        view.addSubview(activity)
        
        activity.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        communityCollectionView.refreshControl = UIRefreshControl()
        communityCollectionView.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    }
    
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
        
        communityFloatingButton.items[0].addTarget(self, action: #selector(ReviewButtonPressed(_:)), for: .touchUpInside)
        communityFloatingButton.items[1].addTarget(self, action: #selector(PersonalReviewButtonPressed(_:)), for: .touchUpInside)

        communityFloatingButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    
    @objc func themeFiltering() {
        communityNavigationBar.NavTheme.resignFirstResponder()
        communityViewModel.getFilterList(pickerData: filterTheme)
     }

    
    @objc func ReviewButtonPressed(_: UIButton)
    {
        var alertData : [UIAlertAction] = []
        let alert = UIAlertController(title: "리뷰를 작성하세요.", message: "작성할 여행 리스트 제목을 클릭해주세요.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        for idx in 0..<journeyList.count {
            alertData.append(UIAlertAction(title: journeyList[idx].title, style: .default, handler: { UIAlertAction in
                let reviewVC = ReviewWriteViewController(title: self.journeyList[idx].title, sDate: self.journeyList[idx].sDate, eDate: self.journeyList[idx].eDate)
                self.navigationController!.pushViewController(reviewVC, animated: true)
            }))
            alert.addAction(alertData[idx])
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }

    @objc func PersonalReviewButtonPressed(_: UIButton)
    {
        communityViewModel.getPersonalList()
    }
    
    @objc func onRefresh() {
        communityViewModel.getList()
        getJourneyData()
    }
}

// MARK: - extensions

extension CommunityViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return communityViewModel.communityDataListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommunityCollectionViewCell
        let communityDataInfo = communityViewModel.getCommunity(index: indexPath.row)
        cell.backgroundColor = themeColor
        cell.setData(communityDataInfo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let communityDetailVC = DestinationDetailViewController()
//        self.navigationController!.pushViewController(communityDetailVC, animated: true)
        print("Clicked \(indexPath.row)")
    }
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
        filterTheme = commuinityCategorydata[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return commuinityCategorydata[row]
    }
}

// MARK: - TextField 왼쪽 공백 없애기
//extension UITextField {
//    func addLeftPadding() {
//      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
//      self.leftView = paddingView
//      self.leftViewMode = ViewMode.always
//    }
//}

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


extension CommunityViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        communityViewModel.putSearWord(word: communityNavigationBar.NavSearchBar.text!)
        communityViewModel.getSearchList()
    }
}

//
//  reviewViewController.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/13.
//

import UIKit
import Then
import BSImagePicker
import Photos

let photoID = "photoCell"


class ReviewWriteViewController: UIViewController {

    // MARK: - Properties
    var selectedAssets: [PHAsset] = []
    var selectedImages: [UIImage] = []
    
    var titleSendFromCommunity: String
    var sDateSendFromCommunity: String
    var eDateSendFromCommunity: String
    var themeSendFromCommunity: String
    
    var reviewView : ReviewScrollView!
    var reviewViewModel: ReviewViewModel!
    private var reviewDataWillSendToVM: ReviewData = ReviewData.shared
    var shopListSendFromCommunity: [ShopListDetail]

    
    let picker = UIImagePickerController()
    let activity = UIActivityIndicatorView()
    let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    init(title titleSendFromCommunity: String, sDate sDateSendFromCommunity: String, eDate eDateSendFromCommunity: String, theme themeSendFromCommunity: String, shopList shopListSendFromCommunity: [ShopListDetail]) {
        self.titleSendFromCommunity = titleSendFromCommunity
        self.eDateSendFromCommunity = eDateSendFromCommunity
        self.sDateSendFromCommunity = sDateSendFromCommunity
        self.themeSendFromCommunity = themeSendFromCommunity
        self.shopListSendFromCommunity = shopListSendFromCommunity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var test = ImagePickerController().then {
    $0.modalPresentationStyle = .automatic
    $0.settings.selection.max = 10
    $0.settings.theme.selectionStyle = .numbered
    $0.settings.fetch.assets.supportedMediaTypes = [.image]
    $0.settings.theme.selectionFillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    $0.settings.theme.selectionStrokeColor = .white
    $0.settings.theme.selectionShadowColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    $0.doneButton.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    $0.cancelButton.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    $0.albumButton.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    $0.doneButtonTitle = "선택완료"
}

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewView = ReviewScrollView()
        reviewViewModel = ReviewViewModel()
        setNav()
        setKeyBoard()
        setDelegate()
        setReviewView()
        setCollection()
    }
    
    // MARK: - 메소드

    func setCollection() {
        reviewView.photoButton.addTarget(self, action: #selector(photoButtonPressed), for: .touchUpInside)
        reviewView.reviewPhotoCollectionView.register(ReviewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: photoID)
        
        // 사진 드레그 관련
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        reviewView.reviewPhotoCollectionView.addGestureRecognizer(gesture)
    }

    func setRefresh() {
        view.addSubview(activity)
        
        activity.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        reviewViewModel.loadingStarted = { [weak activity] in
            activity?.isHidden = false
            activity?.startAnimating()
        }
        reviewViewModel.loadingEnded = { [weak activity] in
            activity?.stopAnimating()
        }
    }
    
    func setKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setNav() {
        let finishedButton = UIBarButtonItem(title: "등록하기", style: .plain, target: self, action: #selector(finishedButtonClicked))
        self.navigationItem.rightBarButtonItem = finishedButton
    }
    
    func setDelegate() {
        reviewView.reviewPhotoCollectionView.dataSource = self
        reviewView.reviewPhotoCollectionView.delegate = self
        reviewView.reviewTextView.delegate = self
        reviewView.hashtagTextView.delegate = self
    }
    
    func setReviewView() {
        view.backgroundColor = GlobalConstants.Color.Background.themeColor
        view.addSubview(reviewView)
        
        reviewView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        reviewView.travelTitleTextView.text = titleSendFromCommunity
        reviewView.dateTextView.text = sDateSendFromCommunity + " ~ " + eDateSendFromCommunity
    }
    
    @objc func finishedButtonClicked(_ sender: Any) {
        reviewDataWillSendToVM.title = titleSendFromCommunity
        reviewDataWillSendToVM.startDate =
        sDateSendFromCommunity
        reviewDataWillSendToVM.endDate = eDateSendFromCommunity
        reviewDataWillSendToVM.content = reviewView.reviewTextView.text
        reviewDataWillSendToVM.tags = reviewView.hashtagTextView.text
        reviewDataWillSendToVM.theme = themeSendFromCommunity
        reviewDataWillSendToVM.shopList = shopListSendFromCommunity
        
        if (self.selectedImages.isEmpty) {
            let alert = UIAlertController(title: "사진을 첨부해주세요.", message: "한 개 이상의 사진을 넣어주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            // 파라미터 먼저 넣어주기
            reviewViewModel.setReviewParams(reviewData: reviewDataWillSendToVM, idx: shopListSendFromCommunity.count)
            // 이미지와 함께 호출 시
            reviewViewModel.setReviewDataWithImage(reviewData: reviewDataWillSendToVM, idx: shopListSendFromCommunity.count, previousImages: selectedImages)
            // 이미지 없이 호출 시
            // reviewViewModel.setReviewData()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func handleLongPressGesture(_ gesture: UITapGestureRecognizer) {
        let collectionView = reviewView.reviewPhotoCollectionView
        
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func openLibrary()
    {
        self.presentImagePicker(test,
        select: {
            (asset) in
                // 사진 하나 선택할 때마다 실행되는 내용 쓰기
        }, deselect: {
            (asset) in
                // 선택했던 사진들 중 하나를 선택 해제할 때마다 실행되는 내용 쓰기
        }, cancel: {
            (assets) in
                // Cancel 버튼 누르면 실행되는 내용
        }, finish: { [self]
            (assets) in
                // Done 버튼 누르면 실행되는 내용
            self.selectedAssets.removeAll()
            self.selectedImages.removeAll()
            for i in assets {
                self.selectedAssets.append(i)
            }
            self.converAssetToImages()
            reviewView.reviewPhotoCollectionView.reloadData()
            
            
            
            
            
        })
    }
    
    func converAssetToImages()
    {
        if test.selectedAssets.count != 0 {
            for i in 0..<test.selectedAssets.count {
                
                let imageManager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                var thumbnail = UIImage()
                
                imageManager.requestImage(for: test.selectedAssets[i],
                                             targetSize: CGSize(width: 200, height: 200),
                                             contentMode: .aspectFit,
                                             options: option) { (result, info) in
                    thumbnail = result!
                }
                let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                self.selectedImages.append(newImage! as UIImage)
            }
        }
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else {
            print("Simulator doesn't have Camera")
        }
    }

    @objc func photoButtonPressed(_: UIButton) {
        let alert = UIAlertController(title: "사진을 골라주세요.", message: "", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) {(action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - extentions

extension ReviewWriteViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoID, for: indexPath) as! ReviewPhotoCollectionViewCell
        print(indexPath.row)
        cell.imageSelectedView.image = self.selectedImages[indexPath.row]
        cell.imageSelectedView.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = reviewView.reviewPhotoCollectionView.frame.width
        let height = reviewView.reviewPhotoCollectionView.frame.height
        let itemsPerRow: CGFloat = 1
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 1
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = selectedImages.remove(at: sourceIndexPath.row)
        selectedImages.insert(item, at: destinationIndexPath.row)
    }
    
}

// TextView 관련 Extension
extension ReviewWriteViewController : UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if "#제주 #우정 #10년지기" == textView.text {
            reviewView.hashtagTextView.text = nil
        }
        
        if "리뷰를 등록해주세요." == textView.text {
            reviewView.reviewTextView.text = nil
        }
        textView.textColor = .black
        textView.layer.borderColor = UIColor.black.cgColor
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.lightGray.cgColor
        if textView.text == reviewView.hashtagTextView.text, reviewView.hashtagTextView.text == "" {
            reviewView.hashtagTextView.text = "#제주 #우정 #10년지기"
            reviewView.hashtagTextView.textColor = .lightGray
        } else if textView.text == reviewView.reviewTextView.text, reviewView.reviewTextView.text == "" {
            reviewView.reviewTextView.text = "리뷰를 등록해주세요."
            reviewView.reviewTextView.textColor = .lightGray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        return true
        }
    
    func textViewDidChange(_ textView: UITextView) {
        if reviewView.hashtagTextView.text.count > 50 {
            reviewView.hashtagTextView.deleteBackward()
        }
    }
}


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
    let scrollView = UIScrollView()
    let contentView = UIView()
    let headerview = UIView()
    
    var titleSendFromCommunity : String
    var sDateSendFromCommunity : String
    var eDateSendFromCommunity : String
    
    init(title titleSendFromCommunity: String, sDate sDateSendFromCommunity: String, eDate eDateSendFromCommunity: String) {
        self.titleSendFromCommunity = titleSendFromCommunity
        self.eDateSendFromCommunity = eDateSendFromCommunity
        self.sDateSendFromCommunity = sDateSendFromCommunity
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerTitle = UILabel().then({
        $0.text = "리뷰를 작성하여\n여행을 함께 공유해요!"
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.numberOfLines = 0
        $0.textColor = #colorLiteral(red: 0.3333333333, green: 0.7254901961, blue: 0.737254902, alpha: 1)
    })
    
    lazy var travelTitle = UILabel().then {
        $0.text = "제목을 입력하세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var travelTitleTextView = UITextView().then {
        $0.text = titleSendFromCommunity
//        $0.textAlignment = .natural
        $0.font = .systemFont(ofSize: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 10
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
    }
    
    lazy var hashtagTitle = UILabel().then {
        $0.text = "해쉬태그를 입력해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var hashtagTextView = UITextView().then {
        if ($0.text.isEmpty) {
            $0.text = "#제주 #우정 #10년지기"
            $0.textColor = .lightGray
        }
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
    }
    
    lazy var dateTitle = UILabel().then {
        $0.text = "언제부터 언제까지 다녀오셨나요?"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var dateTextView = UITextView().then {
        $0.text = sDateSendFromCommunity + " ~ " + eDateSendFromCommunity
        $0.font = .systemFont(ofSize: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
    }
    
    lazy var reviewTitle = UILabel().then {
        $0.text = "리뷰"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var reviewTextView = UITextView().then {
        if ($0.text.isEmpty) {
            $0.text = "리뷰를 등록해주세요."
            $0.textColor = .lightGray
        }
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

    }
    
    lazy var photoTitle = UILabel().then {
        $0.text = "사진을 등록 해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var photoButton = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.setTitleColor(.black, for: .normal)
        $0.frame(forAlignmentRect: CGRect(x: 10, y: 10, width: 10, height: 10))
        $0.backgroundColor = #colorLiteral(red: 0.8784313798, green: 0.8784313798, blue: 0.8784313798, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
    }
    
    let picker = UIImagePickerController()
    
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

    lazy var reviewPhotoCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        flowlayout.scrollDirection = .horizontal
        flowlayout.minimumLineSpacing = 20
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.backgroundColor = UIColor(red: 243/255, green: 255/255, blue: 251/255, alpha: 1)
        return cv
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 243/255, green: 255/255, blue: 251/255, alpha: 1)
//        picker.delegate = self
        Setup()
        headerSetUp()
        bodySetup()
        photoButton.addTarget(self, action: #selector(photoButtonPressed), for: .touchUpInside)
        
        reviewPhotoCollectionView.dataSource = self
        reviewPhotoCollectionView.delegate = self
        reviewPhotoCollectionView.register(ReviewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: photoID)
        
        // 사진 드레그 관련
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        reviewPhotoCollectionView.addGestureRecognizer(gesture)
        
        // 네비게이션 등록관련 
        let finishedButton = UIBarButtonItem(title: "등록하기", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = finishedButton
        
        
        reviewTextView.delegate = self
        hashtagTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    
    @objc func handleLongPressGesture(_ gesture: UITapGestureRecognizer)
    {
        let collectionView = reviewPhotoCollectionView
        
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

    // MARK: - Helpers
    
    func Setup()
    {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            $0.width.greaterThanOrEqualTo(scrollView.snp.width)
    
        }
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
    }
    
    func headerSetUp()
    {
        contentView.addSubview(headerview)
        contentView.addSubview(headerTitle)
        headerview.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width)
            $0.top.equalTo(contentView.snp.top)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.2)
        }
        headerTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(headerview.snp.height).multipliedBy(0.7)
            $0.bottom.equalTo(headerview.snp.bottom)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
    }

    
    func bodySetup()
    {
        contentView.addSubview(travelTitle)
        contentView.addSubview(travelTitleTextView)
        contentView.addSubview(hashtagTitle)
        contentView.addSubview(hashtagTextView)
        contentView.addSubview(dateTitle)
        contentView.addSubview(dateTextView)
        contentView.addSubview(reviewTitle)
        contentView.addSubview(reviewTextView)
        contentView.addSubview(photoTitle)
        contentView.addSubview(photoButton)
        contentView.addSubview(reviewPhotoCollectionView)
        
        travelTitleTextView.isScrollEnabled = false
        travelTitleTextView.isEditable = false
        dateTextView.isScrollEnabled = false
        dateTextView.isEditable = false

        travelTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(headerview.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        travelTitleTextView.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(travelTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        hashtagTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(travelTitleTextView.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        hashtagTextView.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(hashtagTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        dateTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(hashtagTextView.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        dateTextView.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(dateTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        reviewTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(dateTextView.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(200)
            $0.top.equalTo(reviewTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        photoTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(reviewTextView.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
        }
        
        photoButton.snp.makeConstraints {
            $0.top.equalTo(photoTitle.snp.bottom)
            $0.leading.equalTo(headerview.snp.leading).offset(30)
            $0.height.equalTo(30)
        }
        
        
        reviewPhotoCollectionView.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(200)
            $0.top.equalTo(photoButton.snp.bottom).offset(10)
            $0.leading.equalTo(headerview.snp.leading).offset(20)
            $0.bottom.equalToSuperview()
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
            #if DEBUG
            print("==========<finish>==========")
            #endif
            self.selectedAssets.removeAll()
            print("before : \(selectedAssets)")
            print("before : \(selectedImages)")

            for i in assets {
                self.selectedAssets.append(i)
            }
            self.converAssetToImages()
            self.reviewPhotoCollectionView.reloadData()
            print("After : \(selectedAssets)")
            print("After : \(selectedImages)")
            print("==========</finish>==========")
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
    
    
    func openCamera(){

        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else {
            print("Simulator doesn't have Camera")
        }
        

    }

    @objc func photoButtonPressed(_: UIButton)
    {
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
        cell.imageSelectedView.image = self.selectedImages[indexPath.row]
        cell.imageSelectedView.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 80, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = selectedImages.remove(at: sourceIndexPath.row)
        selectedImages.insert(item, at: destinationIndexPath.row)
    }
    
}
//
//
//extension reviewWriteViewController : UIImagePickerControllerDelegate, UINavigationBarDelegate
//{
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
////                  photoImageView.image = image
//                  print(info)
//              }
//              dismiss(animated: true, completion: nil)
//    }
//}
//
//
//


// 검색창 하다가 만 것
extension ReviewWriteViewController : UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if "#제주 #우정 #10년지기" == hashtagTextView.text {
            hashtagTextView.text = nil
        }
        
        if "리뷰를 등록해주세요." == reviewTextView.text {
            reviewTextView.text = nil
        }
        textView.textColor = .black
        textView.layer.borderColor = UIColor.black.cgColor
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        return true
        }
    
    func textViewDidChange(_ textView: UITextView) {
        if hashtagTextView.text.count > 50 {
            hashtagTextView.deleteBackward()
        }
    }
}


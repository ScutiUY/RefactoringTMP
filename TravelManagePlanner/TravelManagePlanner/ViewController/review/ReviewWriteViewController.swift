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


class reviewWriteViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Properties
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerview = UIView()
    
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
    
    lazy var travelTextField = UITextField().then {
        $0.placeholder = "민수와 제주도 우정여행"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
    }
    
    lazy var hashtagTitle = UILabel().then {
        $0.text = "해쉬태그를 입력해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var hashtagTextField = UITextField().then {
        $0.placeholder = "#제주 #우정 #10년지기"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
    }
    
    lazy var foodTitle = UILabel().then {
        $0.text = "다녀온 맛집이 어디인가요?"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var foodTextField = UITextField().then {
        $0.placeholder = "#돌하르방삼겹살 #장독김치국수"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
    }

    lazy var sleepTitle = UILabel().then {
        $0.text = "어떤 숙소에서 머무르셨나요?"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var sleepTextField = UITextField().then {
        $0.placeholder = "#델리호텔 #예스호텔"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
    }
    
    lazy var reviewTitle = UILabel().then {
        $0.text = "리뷰"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = #colorLiteral(red: 0.5095663667, green: 0.5823678374, blue: 0.5935699344, alpha: 1)
    }
    
    lazy var reviewTextField = UITextField().then {
        $0.placeholder = "리뷰를 등록해주세요."
        $0.backgroundColor = .white
        $0.frame.size.height = 100
        $0.frame.size.width = 200
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
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
        cv.backgroundColor = .red
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
        reviewPhotoCollectionView.register(reviewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: photoID)
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
        contentView.addSubview(travelTextField)
        contentView.addSubview(hashtagTitle)
        contentView.addSubview(hashtagTextField)
        contentView.addSubview(foodTitle)
        contentView.addSubview(foodTextField)
        contentView.addSubview(sleepTitle)
        contentView.addSubview(sleepTextField)
        contentView.addSubview(reviewTitle)
        contentView.addSubview(reviewTextField)
        contentView.addSubview(photoTitle)
        contentView.addSubview(photoButton)



        travelTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(headerview.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        travelTextField.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(travelTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        hashtagTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(travelTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        hashtagTextField.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(hashtagTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        foodTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(hashtagTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        foodTextField.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(foodTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        sleepTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(foodTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        sleepTextField.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(sleepTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        reviewTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(sleepTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        reviewTextField.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(reviewTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        photoTitle.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.top.equalTo(reviewTextField.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
        }
        
        photoButton.snp.makeConstraints {
            $0.top.equalTo(photoTitle.snp.bottom)
            $0.left.equalTo(headerview.snp.left).offset(30)
        }
        
        
        // MARK: -
        
        contentView.addSubview(reviewPhotoCollectionView)
        reviewPhotoCollectionView.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(200)
            $0.top.equalTo(photoButton.snp.bottom).offset(10)
            $0.left.equalTo(headerview.snp.left).offset(20)
            $0.bottom.equalToSuperview()
        }

        // MARK: -
    }
    func openLibrary()
    {
        presentImagePicker(test,
        select: {
            (asset) in
                // 사진 하나 선택할 때마다 실행되는 내용 쓰기
            
        }, deselect: {
            (asset) in
                // 선택했던 사진들 중 하나를 선택 해제할 때마다 실행되는 내용 쓰기
            
        }, cancel: {
            (assets) in
                // Cancel 버튼 누르면 실행되는 내용
            
        }, finish: {
            (assets) in
                // Done 버튼 누르면 실행되는 내용
            print("Finished with selections: \(assets.count)")
            print("Finished with selections: \(self.test.selectedAssets.count)")
            for i in 0..<assets.count
            {
//                self.test.selectedAssets.
            }
            
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

extension reviewWriteViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.test.selectedAssets.count
    }
    
//    func collectionview
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoID, for: indexPath) as! reviewPhotoCollectionViewCell
        
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 80, height: view.frame.height)
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

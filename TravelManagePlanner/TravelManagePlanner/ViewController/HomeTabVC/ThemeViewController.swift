//
//  ThemeViewController.swift
//  TravelManagerPlanner
//
//  Created by YoonDaeSung on 2022/01/01.
//

import UIKit

// 커밋 테스트
class ThemeViewController: UIViewController{
    let cellID = "Cell"
    // Assets의 사진 출력
    lazy var imgDataName = ["커플", "가족", "우정", "기타"]
    
    var imgArray: [UIImage] {
        var img:[UIImage] = []
        
        for i in imgDataName {
            if let asImg = UIImage(named: i) {
                
                img.append(asImg)
            }else {
                print("Theme imgData is nil")
            }
        }
        return img
    }
    
    // 테마 타이틀
    lazy var themeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "홍길동님 환영합니다"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    // 테마 서브 타이틀
    lazy var themeSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행준비를 시작해볼까요?"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        
        return label
    }()
    
    let themeCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        // 셀 가로세로 정의(미정의시 가로 디폴트)
        flowlayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView (frame: .zero, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GlobalConstants.Color.Background.themeColor
        setUpView()
        setLayout()
        setDelegate()
    }
    
    
    
    // 뷰 요소들 화면에 세팅하기
    func setUpView() {
        view.addSubview(themeTitleLabel)
        view.addSubview(themeSubTitleLabel)
        view.addSubview(themeCollectionView)
        //        view.addSubview(imageViewCell)
        
        
    }
    
    // 뷰 레이아웃 설정
    func setLayout() {
        themeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        themeSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(themeTitleLabel.snp.bottom).multipliedBy(1)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        themeCollectionView.snp.makeConstraints {
            $0.top.equalTo(themeSubTitleLabel.snp.bottom).multipliedBy(1.3)
            $0.leading.equalTo(view.snp.centerX).multipliedBy(0.1)
            $0.bottom.equalToSuperview().offset(-54)
            $0.trailing.equalToSuperview().offset(-24)
            
            
        }
        
        
        //        imageViewCell.snp.makeConstraints {
        //            $0.top.equalTo(themeCollectionView.snp.top).multipliedBy(1.3)
        //            $0.leading.equalToSuperview().offset(24)
        //            $0.right.equalToSuperview().offset(-24)
        //
        //            // 콜렉션뷰에 cell넣어주기 여기서 설정하는게 맞나?
        //        }
        //
    } // setConstraints
    
    func setDelegate() {
        
        // cell 사용을위한 권한 주기
        themeCollectionView.dataSource = self
        themeCollectionView.delegate = self
        
        // 어떤셀을 쓸건지 지정, 어떤이름으로 쓸건지 지정
        themeCollectionView.register(ThemeViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
} // class

extension ThemeViewController: UICollectionViewDataSource {
    
    // 셀 갯수 설정(필수)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imgDataName.count
    }
    
    // 셀 데이터 내용 불러오기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ThemeViewCell
        
        //      cell.imageView.image = (imgArray[indexPath.row])
        cell.cellLoadImage(imgDataName[indexPath.row])
        cell.imgLabel.text = imgDataName[indexPath.row]
        
        return cell
    }
    
    // 해당 셀 선택시에 액션
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //해당 셀클릭시 디테일 버튼 추후 구현하기
        //collectionView.cellForItemAtIndexPath(1)?.backgroundColor = UIColor.grayColor
        
        // 내가고른게 선택되는지 찍어보기
        print("클릭됬니")
    }
}


extension ThemeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("테마뷰 클릭")
        print(indexPath)
        // main에 있는 두번째화면 불러오기(스토리보드 활용)
        let nextView = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "DetaileSettingViewSB") as! DetaileSettingViewController
        
        // 다음화면에서 바텀탭 없애기
        nextView.hidesBottomBarWhenPushed = true
        navigationController!.pushViewController(nextView, animated: true)
    }
}

// cell 사이즈 정의
extension ThemeViewController: UICollectionViewDelegateFlowLayout {

    // cell 가운대 정렬 정의
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInsets = UIEdgeInsets(top: 2, left: 5, bottom: 0, right: 5)
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 3
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    // Cell간격 조절
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
}

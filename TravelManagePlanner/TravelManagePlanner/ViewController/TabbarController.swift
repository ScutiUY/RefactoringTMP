//
//  TabbarController.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/02.
//

import UIKit

class TabbarController: UITabBarController {
    
    /// Tabbar Controller
    /// 해당 Tabbar Controller에서 이동 할 수 있는 VC를 TabbarItem으로 추가해 주면 됩니다.
    /// 추가해 놓은 VC는 샘플이므로 추가할 VC로 교체 하면 됩니다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // VC 선언 부분
        let homeVC = UIStoryboard(name: "HomeTabSB", bundle: nil).instantiateViewController(withIdentifier: "ThemeViewSB")
        let journeyListVC = UIStoryboard(name: "JourneyListSB", bundle: nil).instantiateViewController(withIdentifier: "JourneyListSB") // 여행 리스트 VC
        let commuityVC = CommunityViewController() // 커뮤니티 VC
        let sampleVC3 = MypageViewController() // 마이페이지 VC
        
        // 홈 탭
        // Tab의 VC 목록에 해당 VC를 넣을 때 Navigation Controller에 넣어서 추가하면 네비게이션 컨트롤러를 자동으로 상속 합니다
        let homeTab = UINavigationController(rootViewController: homeVC)
        homeTab.tabBarItem.image = UIImage(named: "Home2")!.resizedImage(targetSize: CGSize(width: 25, height: 25))
        homeTab.title = "Home".localized
        // 여행 리스트 탭
        let journeyListTab = UINavigationController(rootViewController: journeyListVC)
        journeyListTab.tabBarItem.image = UIImage(named: "List3")!.resizedImage(targetSize: CGSize(width: 25, height: 25))
        journeyListTab.title = "Journey List".localized
        
        // 커뮤니티 탭
        let commuTab = UINavigationController(rootViewController: commuityVC)
        commuTab.tabBarItem.image = UIImage(named: "Community2")!.resizedImage(targetSize: CGSize(width: 25, height: 25))
        commuTab.title = "Community".localized
        
        // 마이 페이지 탭
        let myPageTab = UINavigationController(rootViewController: sampleVC3)
        myPageTab.tabBarItem.image = UIImage(named: "MyPage")!.resizedImage(targetSize: CGSize(width: 25, height: 25))
        myPageTab.title = "My page".localized
        
        self.viewControllers = [homeTab, journeyListTab, commuTab, myPageTab]
        
    }
    

}

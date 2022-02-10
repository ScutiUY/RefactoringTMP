//
//  RecommendPageViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//

import UIKit
import SnapKit


// 숙박, 식당, 놀거리 추천지 Page
class RecommendPageViewController: UIPageViewController {
    var recommendVCArray: [UIViewController] = {
        let storyBoard = UIStoryboard(name: "HomeTabSB", bundle: nil)
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "AccomoViewSB") // 숙박
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "RestaurantViewSB") // 식당
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "TourAreaViewSB") // 관광지역
        
        return [vc1, vc2, vc3]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        //        pageControl.backgroundStyle = .prominent
        if let firstVC = recommendVCArray.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        //        self.recommendVCArray.backgroundStyle = .prominent
    }
    
    //     백그라운드 블랙 없애기
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            }else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    //    func setUpView() {
    //        view.addSubview(pageController)
    //    }
    
    //    func setLayout() {
    //    }
    
    func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
    
}

extension RecommendPageViewController: UIPageViewControllerDelegate{
    
}

extension RecommendPageViewController: UIPageViewControllerDataSource{
    
    // 이전 페이지
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = recommendVCArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else{
            return recommendVCArray.last
        }
        
        guard recommendVCArray.count > previousIndex else{
            return nil
        }
        
        return recommendVCArray[previousIndex]
    }
    
    // 다음 페이지
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = recommendVCArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < recommendVCArray.count else{
            return recommendVCArray.first
        }
        
        guard recommendVCArray.count > nextIndex else{
            return nil
        }
        
        return recommendVCArray[nextIndex]
    }
    
    // 페이지 카운트(인디케이터 갯수)
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return recommendVCArray.count
    }
    
    // 인디케이터 초기값
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

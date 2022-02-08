//
//  RecommendPageViewController.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//

import UIKit

// 숙박, 식당, 놀거리 추천지 Page
class RecommendPageViewController: UIPageViewController {
    
    // 필요 뷰컨트롤러 담기
    var recommendVCArray: [UIViewController] = {
       
        let storyBoard = UIStoryboard(name: "HomeTabSB", bundle: nil)
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "AccomoViewSB")
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "RestaurantViewSB")
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "RestaurantViewSB")
        
        return [vc1, vc2]
    }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        
        if let firstVC = recommendVCArray.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            
        }
    }
    
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
    
    // 페이지 카운트
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return recommendVCArray.count
    }
    
}

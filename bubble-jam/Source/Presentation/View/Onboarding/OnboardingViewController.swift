//
//  OnboardingViewController.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 07/12/22.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRect()
        pageControl.numberOfPages = self.pages.count
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9254901961, green: 0.3921568627, blue: 0.7058823529, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            } else {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewContollerIndex = self.pages.firstIndex(of: viewController) {
            if viewContollerIndex < self.pages.count - 1 {
                return pages[viewContollerIndex+1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

}

extension OnboardingViewController: ViewCoding {
    func setupView() {
        self.dataSource = self
        self.delegate = self
        let page1 = Page1ViewController()
        let page2 = Page2ViewController()
        let page3 = Page3ViewController()
        let initialPage = 0
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pageControl.currentPage = initialPage
        pageControl.isUserInteractionEnabled = false
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        
    }
    
    func setupHierarchy() {
        view.addSubview(pageControl)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }
    
}

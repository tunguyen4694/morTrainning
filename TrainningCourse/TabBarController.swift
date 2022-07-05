//
//  TabBarController.swift
//  TrainningCourse
//
//  Created by MorHN on 05/07/2022.
//

import Foundation
import UIKit


class TabBarController: UITabBarController {
    
    let vTopLineTabbar = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        
        tabBar.tintColor = .mainColor()
        tabBar.unselectedItemTintColor = .iconColor()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .default)
        
        let controller1 = UIStoryboard(name: "HomeVC", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
        controller1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill", withConfiguration: iconConfig), tag: 1)
        let nav1 = UINavigationController(rootViewController: controller1)
        
        let controller2 = UIStoryboard(name: "CourseVC", bundle: nil).instantiateViewController(withIdentifier: "CourseVC")
        controller2.tabBarItem = UITabBarItem(title: "Course", image: UIImage(systemName: "book.closed.fill", withConfiguration: iconConfig), tag: 2)
        let nav2 = UINavigationController(rootViewController: controller2)
        
        let controller3 = UIStoryboard(name: "SearchVC", bundle: nil).instantiateViewController(withIdentifier: "SearchVC")
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.title = "Search"
        
        let controller4 = UIStoryboard(name: "MessageVC", bundle: nil).instantiateViewController(withIdentifier: "MessageVC")
        controller4.tabBarItem = UITabBarItem(title: "Message", image: UIImage(systemName: "message.fill", withConfiguration: iconConfig), tag: 4)
        let nav4 = UINavigationController(rootViewController: controller4)
        
        let controller5 = UIStoryboard(name: "AccountVC", bundle: nil).instantiateViewController(withIdentifier: "AccountVC")
        controller5.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.fill", withConfiguration: iconConfig), tag: 5)
        let nav5 = UINavigationController(rootViewController: controller5)
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12),
             NSAttributedString.Key.foregroundColor: UIColor.borderColor()], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12),
             NSAttributedString.Key.foregroundColor: UIColor.mainColor()], for: .selected)
        
        configTabBar()
        //        tabBar.items![2].isEnabled = false
    }
    
    func configTabBar() {
        tabBar.layer.cornerRadius = 10
        tabBar.addSubview(vTopLineTabbar)
        vTopLineTabbar.frame = .init(x: tabBar.frame.width/20, y: 0, width: tabBar.frame.width/10, height: 2)
        vTopLineTabbar.backgroundColor = .mainColor()
        
        let vClear = UIView()
        tabBar.addSubview(vClear)
        vClear.frame = .init(x: 0, y: tabBar.bounds.minY, width: 60, height: 60)
        vClear.center.x = tabBar.center.x
        vClear.backgroundColor = .clear
        
        let vBigCircle = UIView()
        tabBar.addSubview(vBigCircle)
        vBigCircle.frame = .init(x: 0, y: tabBar.bounds.minY-25, width: 60, height: 60)
        vBigCircle.center.x = tabBar.center.x
        vBigCircle.layer.cornerRadius = 30
        vBigCircle.backgroundColor = .white
        
        let vSmallCircle = UIView()
        vBigCircle.addSubview(vSmallCircle)
        vSmallCircle.frame = .init(x: 5, y: 5, width: 50, height: 50)
        vSmallCircle.layer.cornerRadius = 25
        vSmallCircle.backgroundColor = .mainColor()
        vSmallCircle.alpha = 0.05
        
        let btnSearch = UIButton()
        vBigCircle.addSubview(btnSearch)
        btnSearch.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btnSearch.tintColor = .mainColor()
        btnSearch.frame = .init(x: 0, y: 0, width: 60, height: 60)
        btnSearch.addTarget(self, action: #selector(onSearch(_:)), for: .touchUpInside)
        
    }
    
    @objc func onSearch(_ sender: UIButton) {
        let sb = UIStoryboard(name: "SearchVC", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SearchVC") as? SearchViewController else { return }
        //        self.navigationController?.present(vc, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        //        if item == (self.tabBar.items!)[2]{
        //            tabBar.isHidden = true
        //        }
        
        guard let indexOfTab = tabBar.items?.firstIndex(of: item) else{ return }
        
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveLinear, animations: {
            self.vTopLineTabbar.transform = CGAffineTransform(translationX: self.tabBar.frame.width/5*CGFloat(indexOfTab), y: 0)
        }, completion: nil)
    }
}

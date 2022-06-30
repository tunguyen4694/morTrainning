//
//  BaseTarBarController.swift
//  TrainningCourse
//
//  Created by MorHN on 24/06/2022.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    var customTabBar: CustomTabBar!
    var tabBarHeight: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
        setupMiddleButton()
    }
    
    func loadTabBar() {
        // Tạo và load custom tab bar
        let tabbarItems: [TabItem] = [.homes, .courses, .searchs, .messages, .accounts]
        setupCustomTabMenu(tabbarItems, completion: { viewControllers in
            self.viewControllers = viewControllers
        })
        selectedIndex = 0 // Set default selected index thành item đầu tiên
    }
    
    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        // Handle custom tab bar và các attach touch event listener
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        // Ẩn tab bar mặc định của hệ thống đi
        tabBar.isHidden = true
        // Khởi tạo custom tab bar
        customTabBar = CustomTabBar(menuItems: menuItems, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.itemTapped = changeTab(tab:)
        view.addSubview(customTabBar)
        view.backgroundColor = .white
        
        // Auto layout cho custom tab bar
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Thêm các view controller tương ứng
        menuItems.forEach({
            controllers.append($0.viewController)
        })
        view.layoutIfNeeded()
        completion(controllers)
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
    
    func setupMiddleButton() {
        let vCircel = UIView()
        let vChildCirle = UIView()
        view.addSubview(vCircel)
        //            vCircel.frame = .init(x: 0, y: customTabBar.frame.minY - 20, width: 60, height: 60)
        vCircel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vCircel.heightAnchor.constraint(equalToConstant: 60),
            vCircel.widthAnchor.constraint(equalToConstant: 60),
            vCircel.topAnchor.constraint(equalTo: customTabBar.topAnchor, constant: -54),
            vCircel.centerXAnchor.constraint(equalTo: customTabBar.centerXAnchor, constant: 0)
        ])
        view.layoutIfNeeded()
        //            vCircel.center.x = view.center.x
        vCircel.backgroundColor = .white
        vCircel.layer.cornerRadius = 30
        view.addSubview(vChildCirle)
        vChildCirle.frame = .init(x: 0, y: 0, width: 50, height: 50)
        vChildCirle.center = vCircel.center
        vChildCirle.backgroundColor = .mainColor()
        vChildCirle.alpha = 0.05
        vChildCirle.layer.cornerRadius = 25
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = vCircel.frame.minY + 5
        menuButtonFrame.origin.x = vCircel.frame.minX + 5
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor.clear
        menuButton.tintColor = .mainColor()
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        menuButton.addTarget(self, action: #selector(searchButtonAction(_:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @objc func searchButtonAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "SearchVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? SearchViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

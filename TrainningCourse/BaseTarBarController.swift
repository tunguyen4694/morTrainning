////
////  BaseTarBarController.swift
////  TrainningCourse
////
////  Created by MorHN on 24/06/2022.
////
//
//import Foundation
//import UIKit
//
//class BaseTabBarController: UITabBarController {
//    var customTabBar: CustomTabBar!
//    var tabBarHeight: CGFloat = 80
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.loadTabBar()
//    }
//    
//    func loadTabBar() {
//            // Tạo và load custom tab bar
//        let tabbarItems: [TabItem] = [.homes, .courses, .searchs, .messages, .accounts]
//        setupCustomTabMenu(tabbarItems, completion: { viewControllers in
//        self.viewControllers = viewControllers
//                })
//        selectedIndex = 0 // Set default selected index thành item đầu tiên
//        }
//
//    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
//        // Handle custom tab bar và các attach touch event listener
//        let frame = tabBar.frame
//        var controllers = [UIViewController]()
//        // Ẩn tab bar mặc định của hệ thống đi
//        tabBar.isHidden = true
//        // Khởi tạo custom tab bar
//        customTabBar = CustomTabBar(menuItems: menuItems, frame: frame)
//        customTabBar.translatesAutoresizingMaskIntoConstraints = false
//        customTabBar.clipsToBounds = true
//        customTabBar.itemTapped = changeTab(tab:)
//        view.addSubview(customTabBar)
//        view.backgroundColor = .white
//
//        // Auto layout cho custom tab bar
//        NSLayoutConstraint.activate([
//        customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
//        customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
//        customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
//        customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
//        customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//
//        // Thêm các view controller tương ứng
//        menuItems.forEach({
//            controllers.append($0.viewController)
//        })
//        view.layoutIfNeeded()
//        completion(controllers)
//        }
//
//        func changeTab(tab: Int) {
//            self.selectedIndex = tab
//        }
//}
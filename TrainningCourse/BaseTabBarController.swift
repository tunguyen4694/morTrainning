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
    var tabBarHeight: CGFloat = 60      // Custom TabBar Height
    
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
    
    // Tạo circle button ở giữa
    func setupMiddleButton() {
        // Tạo 2 circel view bao ngoài button
        let vCircel = UIView()
        let vChildCirle = UIView()
        view.addSubview(vCircel)
        vCircel.backgroundColor = .white
        vCircel.layer.cornerRadius = 30
        vCircel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vCircel.heightAnchor.constraint(equalToConstant: 60),
            vCircel.widthAnchor.constraint(equalToConstant: 60),
            vCircel.topAnchor.constraint(equalTo: customTabBar.topAnchor, constant: -20),
            vCircel.centerXAnchor.constraint(equalTo: customTabBar.centerXAnchor, constant: 0)
        ])
        
        view.addSubview(vChildCirle)
        vChildCirle.backgroundColor = .mainColor()
        vChildCirle.alpha = 0.05
        vChildCirle.layer.cornerRadius = 25
        vChildCirle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vChildCirle.widthAnchor.constraint(equalToConstant: 50),
            vChildCirle.heightAnchor.constraint(equalToConstant: 50),
            vChildCirle.centerXAnchor.constraint(equalTo: vCircel.centerXAnchor),
            vChildCirle.centerYAnchor.constraint(equalTo: vCircel.centerYAnchor)
        ])
        
        let searchButton = UIButton()
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .mainColor()
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 50),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.centerXAnchor.constraint(equalTo: vChildCirle.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: vChildCirle.centerYAnchor)
        ])
        searchButton.addTarget(self, action: #selector(searchButtonAction(_:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    // Set action cho button mid vừa tạo
    @objc func searchButtonAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "SearchVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? SearchViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

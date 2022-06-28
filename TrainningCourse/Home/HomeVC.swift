//
//  Home.swift
//  TrainningCourse
//
//  Created by MorHN on 23/06/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var stHeader: UIStackView!

    @IBOutlet weak var containerHeaderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconHeaderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var progressView: UIProgressView!
    
    let maxContainerHeaderHeight: CGFloat = 250
    let minContainerHeaderHeight: CGFloat = 88
    
    let maxHeaderHeight: CGFloat = 153.0
    let minHeaderHeight: CGFloat = 44.0
    
    let maxTopHeight: CGFloat = 106.0
    let minTopHeight: CGFloat = 0.0
    
    var previousScrollOffSet: CGFloat = 0.0
    
    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var v1Search: UIView!
    @IBOutlet weak var v2Search: UIView!
    
    @IBOutlet weak var vLineHome: UIView!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    
    @IBOutlet weak var vLineCourse: UIView!
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblCourse: UILabel!
    
    @IBOutlet weak var vLineMessage: UIView!
    @IBOutlet weak var imgMessage: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var vLineAcc: UIView!
    @IBOutlet weak var imgAcc: UIImageView!
    @IBOutlet weak var lblAcc: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!

    var arrImage = ["ads", "ads1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("scroll \(previousScrollOffSet)")
        print(scrollView.contentOffset.y)
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        headerHeightConstraint.constant = maxHeaderHeight
        topHeightConstraint.constant = maxTopHeight
        iconHeaderHeightConstraint.constant = 32.0
        updateHeader()
    }

    func configUI() {
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = .mainColor()
        vTop.layer.cornerRadius = 10
        v1Search.layer.cornerRadius = 30
        v2Search.layer.cornerRadius = 25
        
        scrollView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdsCollectionViewCell")
    }
    
    @IBAction func onHome(_ sender: Any) {
        vLineHome.backgroundColor = .mainColor()
        vLineHome.isHidden = false
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .mainColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .mainColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .iconColor()
        
        let sb = UIStoryboard(name: "HomeVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? HomeViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func onCourse(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .mainColor()
        vLineCourse.isHidden = false
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .mainColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .mainColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .iconColor()
        
        let sb = UIStoryboard(name: "CourseVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? CourseViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func onSearch(_ sender: Any) {
        let sb = UIStoryboard(name: "SearchVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? SearchViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
//        print("Search")
    }
    @IBAction func onMessage(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .mainColor()
        vLineMessage.isHidden = false
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .mainColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .mainColor()
        lblAcc.textColor = .iconColor()
        
        let sb = UIStoryboard(name: "MessageVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? MessageViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func onAccount(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .mainColor()
        vLineAcc.isHidden = false
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .mainColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .mainColor()
        
        let sb = UIStoryboard(name: "AccountVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? AccountViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func onMyCourse(_ sender: Any) {
        let sb = UIStoryboard(name: "MyCourseVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? MyCourseViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        let scrollMaxViewHeight = scrollView.frame.height + containerHeaderHeightConstraint.constant - minContainerHeaderHeight
        return scrollView.contentSize.height > scrollMaxViewHeight
    }
    
    func setScrollPosition(_ position: CGFloat) {
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: position)
    }
    
    func scrollViewDidStopScrolling() {
        let range = maxContainerHeaderHeight - minContainerHeaderHeight
        let midPoint = minContainerHeaderHeight + range/2
        
        if containerHeaderHeightConstraint.constant > midPoint {
            expandHeader()
        } else {
            collapseHeader()
        }
    }
    
    func collapseHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.containerHeaderHeightConstraint.constant = self.minContainerHeaderHeight
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.topHeightConstraint.constant = self.minTopHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.containerHeaderHeightConstraint.constant = self.maxContainerHeaderHeight
            self.headerHeightConstraint.constant = self.maxTopHeight
            self.topHeightConstraint.constant = self.maxTopHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func updateHeader() {
        let range = maxContainerHeaderHeight - minContainerHeaderHeight
        let openAmount = containerHeaderHeightConstraint.constant - minContainerHeaderHeight
        let percentage = openAmount/range
        stHeader.alpha = percentage
        progressView.alpha = percentage
        vTop.alpha = percentage
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCollectionViewCell", for: indexPath) as! AdsCollectionViewCell
        cell.imgAds.image = UIImage(named: arrImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width/1.5, height: collectionView.bounds.height)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffSet
        
        let absoluteTop: CGFloat = 0.0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        guard canAnimateHeader(scrollView) else { return }
        
        var newContainerHeaderHeight = containerHeaderHeightConstraint.constant
        var newHeaderHeight = headerHeightConstraint.constant
        var newTopHeight = topHeightConstraint.constant
        var newIconHeight = iconHeaderHeightConstraint.constant
        
        if isScrollingDown {
            newContainerHeaderHeight = max(minContainerHeaderHeight, containerHeaderHeightConstraint.constant - abs(scrollDiff))
            newHeaderHeight = max(minHeaderHeight, headerHeightConstraint.constant - abs(scrollDiff))
            newTopHeight = max(minTopHeight, topHeightConstraint.constant - abs(scrollDiff))
            newIconHeight = max(24.0, iconHeaderHeightConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newContainerHeaderHeight = min(maxContainerHeaderHeight, containerHeaderHeightConstraint.constant + abs(scrollDiff))
            newHeaderHeight = min(maxHeaderHeight, headerHeightConstraint.constant + abs(scrollDiff))
            newTopHeight = min(maxTopHeight, topHeightConstraint.constant + abs(scrollDiff))
            newIconHeight = min(32.0, iconHeaderHeightConstraint.constant+abs(scrollDiff))
        }
        
        if newContainerHeaderHeight != containerHeaderHeightConstraint.constant || newHeaderHeight != headerHeightConstraint.constant || newTopHeight != topHeightConstraint.constant
        {
            containerHeaderHeightConstraint.constant = newContainerHeaderHeight
            headerHeightConstraint.constant = newHeaderHeight
            topHeightConstraint.constant = newTopHeight
            iconHeaderHeightConstraint.constant = newIconHeight
            updateHeader()
            setScrollPosition(previousScrollOffSet)
        }
        previousScrollOffSet = scrollView.contentOffset.y
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidStopScrolling()
        }
    }
}

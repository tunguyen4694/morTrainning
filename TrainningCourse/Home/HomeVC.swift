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
    
    @IBOutlet weak var iconHeaderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var progressView: UIProgressView!
    
    let maxHeaderHeight: CGFloat = 206
    let minHeaderHeight: CGFloat = 44
    
    let maxTopHeight: CGFloat = 106
    let minTopHeight: CGFloat = 0
    
    var previousScrollOffSet: CGFloat = 0
    
    @IBOutlet weak var vTop: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrImage = ["ads", "ads1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        vTop.layer.cornerRadius = 10
        
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdsCollectionViewCell")
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MeetUpTBVC.self, forCellReuseIdentifier: "MeetUpTBVC")
    }
    
    @IBAction func onMyCourse(_ sender: Any) {
        let sb = UIStoryboard(name: "MyCourseVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? MyCourseViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        let scrollMaxViewHeight = scrollView.frame.height + topHeightConstraint.constant - minTopHeight
        return scrollView.contentSize.height > scrollMaxViewHeight
    }
    
    func setScrollPosition(_ position: CGFloat) {
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: position)
    }
    
    func scrollViewDidStopScrolling() {
        let range = maxTopHeight - minTopHeight
        let midPoint = minTopHeight + range/2
        
        if topHeightConstraint.constant > midPoint {
            expandHeader()
        } else {
            collapseHeader()
        }
    }
    
    func collapseHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.topHeightConstraint.constant = self.minTopHeight
            self.iconHeaderHeightConstraint.constant = 24
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.topHeightConstraint.constant = self.maxTopHeight
            self.iconHeaderHeightConstraint.constant = 32
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func updateHeader() {
        let range = maxTopHeight - minTopHeight
        let openAmount = topHeightConstraint.constant - minTopHeight
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
        
        var newHeaderHeight = headerHeightConstraint.constant
        var newTopHeight = topHeightConstraint.constant
        var newIconHeight = iconHeaderHeightConstraint.constant
        
        if isScrollingDown {
            newHeaderHeight = max(minHeaderHeight, headerHeightConstraint.constant - abs(scrollDiff))
            newTopHeight = max(minTopHeight, topHeightConstraint.constant - abs(scrollDiff))
            newIconHeight = max(24.0, iconHeaderHeightConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeaderHeight = min(maxHeaderHeight, headerHeightConstraint.constant + abs(scrollDiff))
            newTopHeight = min(maxTopHeight, topHeightConstraint.constant + abs(scrollDiff))
            newIconHeight = min(32.0, iconHeaderHeightConstraint.constant + abs(scrollDiff))
        }
        
        if newHeaderHeight != headerHeightConstraint.constant
        {
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetUpTBVC", for: indexPath) as! MeetUpTBVC
        cell.imgMeetUp.image = UIImage(named: "meetup")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

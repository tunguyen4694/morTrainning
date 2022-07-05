//
//  Search.swift
//  TrainningCourse
//
//  Created by MorHN on 24/06/2022.
//

import Foundation
import UIKit
import MultiSlider

class SearchViewController: UIViewController {
    
    @IBOutlet weak var vSearch: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var btnDelText: UIButton!
    
    var suggestions = ["Visual idently", "Painting", "Coding", "Writing", "Sale & Marketing", "Photoshop"]
    
    @IBOutlet weak var transparentView: UIView!
    
    @IBOutlet weak var vFilter: UIView!
    @IBOutlet weak var constraintTopVFilter: NSLayoutConstraint!
    @IBOutlet weak var contraintBottomVFilter: NSLayoutConstraint!
    @IBOutlet weak var lblPrice: UILabel!
    let multiSlider = MultiSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Search"
        
        vSearch.layer.cornerRadius = 15
        
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        tfSearch.delegate = self
        addFilter()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func addFilter() {
        vFilter.layer.cornerRadius = 20
        vFilter.backgroundColor = .white
        vFilter.addSubview(multiSlider)
        vFilter.translatesAutoresizingMaskIntoConstraints = false
        multiSlider.translatesAutoresizingMaskIntoConstraints = false
        multiSlider.topAnchor.constraint(equalTo: lblPrice.bottomAnchor, constant: 10).isActive = true
        multiSlider.leadingAnchor.constraint(equalTo: lblPrice.leadingAnchor, constant: 0).isActive = true
        multiSlider.trailingAnchor.constraint(equalTo: lblPrice.trailingAnchor, constant: 0).isActive = true
        multiSlider.maximumValue = 400
        multiSlider.value = [90, 200]
        multiSlider.orientation = .horizontal
        multiSlider.tintColor = .mainColor()
        multiSlider.outerTrackColor = .lightGray
        multiSlider.valueLabelPosition = .bottom
        multiSlider.valueLabelFormatter.positiveSuffix = "$"
        multiSlider.valueLabelColor = .titleColor()
        multiSlider.thumbImage = UIImage(systemName: "circle.fill")
        multiSlider.thumbTintColor = .mainColor()
    }
    
    @IBAction func onDelText(_ sender: Any) {
        tfSearch.text = nil
    }
    
    @IBAction func onFilterSearch(_ sender: Any) {
        transparentView.isHidden = true
        navigationController?.isNavigationBarHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.transparentView.isHidden = false
            //            self.constraintTopVFilter.priority = .defaultLow
            //            self.contraintBottomVFilter.priority = .defaultHigh
            self.vFilter.transform = CGAffineTransform(translationX: 0, y: -self.vFilter.frame.height)
        }, completion: nil)
        print("Filter")
        
    }
    
    @objc func onClickTransparentView() {
        navigationController?.isNavigationBarHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.transparentView.isHidden = true
            //            self.constraintTopVFilter.priority = .defaultHigh
            //            self.contraintBottomVFilter.priority = .defaultLow
            self.vFilter.transform = CGAffineTransform(translationX: 0, y: self.vFilter.frame.height)
        }, completion: nil)
    }
    
    @IBAction func onCloseFilter(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.transparentView.isHidden = true
            //            self.constraintTopVFilter.priority = .defaultHigh
            //            self.contraintBottomVFilter.priority = .defaultLow
            self.vFilter.transform = CGAffineTransform(translationX: 0, y: self.vFilter.frame.height)
        }, completion: nil)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.lblSearch.text = suggestions[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    //        return (collectionView.indexPathsForSelectedItems?.count ?? 0) < 2
    //    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text != nil {
            btnDelText.isHidden = false
        } else {
            btnDelText.isHidden = true
        }
    }
}

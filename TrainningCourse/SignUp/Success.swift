//
//  Success.swift
//  TrainningCourse
//
//  Created by Nguyễn Anh Tú on 20/06/2022.
//

import UIKit

class Success: UIViewController {

    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vContainer.clipsToBounds = true
        vContainer.layer.cornerRadius = 20
        btnDone.clipsToBounds = true
        btnDone.layer.cornerRadius = 20
        btnDone.backgroundColor = .mainColor()
        
    }

    @IBAction func onNextHome(_ sender: Any) {
        let sb = UIStoryboard(name: "HomeVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? HomeViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    


}

//
//  ViewController.swift
//  BK
//
//  Created by Slava Pashaliuk on 3/21/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController {
  
    @IBOutlet weak var motoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 1.5, animations: { self.motoLabel.alpha = 1 })
    }
}




//
//  Registration Component.swift
//  BK
//
//  Created by Slava Pashaliuk on 3/22/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import Foundation
import UIKit

class RegistrationController: UIViewController {

    @IBOutlet weak var TV: UIImageView!
    @IBOutlet weak var Movies: UIImageView!
    @IBOutlet weak var Games: UIImageView!
    var thingsToDo: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        for activity in [TV, Movies,Games] {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            activity!.isUserInteractionEnabled = true
            activity!.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if(thingsToDo.contains(tappedImage.restorationIdentifier!)){
            tappedImage.layer.borderWidth = 0
            thingsToDo.remove(object: tappedImage.restorationIdentifier!)
        }else{
            tappedImage.layer.cornerRadius = 100
            tappedImage.layer.borderWidth = 3.0
            tappedImage.layer.borderColor = CGColor.init(srgbRed: 101/255, green: 155/255, blue: 145/255, alpha: 1.0)
            thingsToDo.append(tappedImage.restorationIdentifier!)
        }
    }
    
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}

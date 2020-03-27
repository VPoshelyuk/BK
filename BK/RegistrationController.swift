//
//  Registration Component.swift
//  BK
//
//  Created by Slava Pashaliuk on 3/22/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import Foundation
import UIKit

class RegistrationController: UIViewController{

    @IBOutlet weak var TV: UIImageView!
    @IBOutlet weak var Movies: UIImageView!
    @IBOutlet weak var Games: UIImageView!
    var thingsToDo: [String] = []
    @IBAction func moveOn(_ sender: Any) {
        if(!thingsToDo.isEmpty) {
            self.performSegue(withIdentifier: "toInterests", sender: self)
        } else {
            let alertController = UIAlertController(
                title: "Oops",
                message: "Please choose at least one category",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Gotcha", style: UIAlertAction.Style.default,handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        for activity in [TV, Movies,Games] {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            activity!.isUserInteractionEnabled = true
            activity!.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let destination = segue.destination as? InterestsController else
       {
          return
       }
       destination.thingsToDo = thingsToDo
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        tappedImage.layer.cornerRadius = 100
        let translation:[CGFloat] = (tappedImage.restorationIdentifier! == "Movies") ? [8.75, -150] : [-8.75, 150]
        let color = CGColor.init(srgbRed: 101/255, green: 155/255, blue: 145/255, alpha: 1.0)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            if(self.thingsToDo.contains(tappedImage.restorationIdentifier!)){
                tappedImage.transform = CGAffineTransform(translationX: translation[0], y: 0)
                tappedImage.layer.borderWidth = 0
                self.thingsToDo.remove(object: tappedImage.restorationIdentifier!)
            }else{
                tappedImage.transform = CGAffineTransform(translationX: translation[1], y: 0)
                tappedImage.layer.borderWidth = 3.0
                tappedImage.layer.borderColor = color
                self.thingsToDo.append(tappedImage.restorationIdentifier!)
            }
        })
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

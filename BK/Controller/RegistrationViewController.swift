//
//  Registration Component.swift
//  BK
//
//  Created by Slava Pashaliuk on 3/22/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import UIKit
import Poi

class RegistrationViewController: UIViewController, PoiViewDataSource, PoiViewDelegate {
    
    @IBOutlet weak var cardView: PoiView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in (0..<50) {
            let card = UIView(frame: CGRect(x: 20, y: 113, width: 374, height: 634))
            
            let title = UILabel(frame: CGRect(x: 0, y: 534, width: 354, height: 30))
            title.text = "Dimon"
            title.textColor = UIColor(red: 239/255, green: 250/255, blue: 211/255, alpha: 1)
            title.textAlignment = .right
            title.font = UIFont(name: "gidole", size: 30)
            
            let genre = UILabel(frame: CGRect(x: 0, y: 564, width: 354, height: 20))
            genre.text = "Action, Drama, Melodrama"
            genre.textColor = UIColor(red: 239/255, green: 250/255, blue: 211/255, alpha: 1)
            genre.textAlignment = .right
            genre.font = UIFont(name: "gidole", size: 18)
                
            let year = UILabel(frame: CGRect(x: 0, y: 584, width: 354, height: 20))
            year.text = "2020"
            year.textColor = UIColor(red: 239/255, green: 250/255, blue: 211/255, alpha: 1)
            year.textAlignment = .right
            year.font = UIFont(name: "gidole", size: 18)
            
            UIGraphicsBeginImageContext(card.frame.size)
            UIImage(named: "test_image")?.draw(in: card.bounds)

            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                card.backgroundColor = UIColor(patternImage: image)
            }else{
                UIGraphicsEndImageContext()
                debugPrint("Image not available")
             }

            card.addSubview(title)
            card.addSubview(genre)
            card.addSubview(year)
            card.layer.cornerRadius = 15
            sampleCards.append(card)
        }
        cardView.dataSource = self
        cardView.delegate = self
    }

    var sampleCards = [UIView]()
    
    func numberOfCards(_ poi: PoiView) -> Int {
        return 50
    }
    
    func poi(_ poi: PoiView, viewForCardAt index: Int) -> UIView {
        return sampleCards[index]
    }
    
    func poi(_ poi: PoiView, didSwipeCardAt: Int, in direction: SwipeDirection) {
        switch direction {
        case .left:
            print("left")
        case .right:
            print("right")
        }
    }
    
    func poi(_ poi: PoiView, runOutOfCardAt: Int, in direction: SwipeDirection) {
        print("last")
    }
    
    func poi(_ poi: PoiView, viewForCardOverlayFor direction: SwipeDirection) -> UIImageView? {
        switch direction {
        case .right:
            return UIImageView(image: #imageLiteral(resourceName: "1aDay"))
        case .left:
            return UIImageView(image: #imageLiteral(resourceName: "1aDay"))
        }
    }
}

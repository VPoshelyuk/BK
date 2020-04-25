//
//  Registration Component.swift
//  BK
//
//  Created by Slava Pashaliuk on 3/22/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import UIKit
import Poi

class RegistrationViewController: UIViewController, PoiViewDataSource, PoiViewDelegate, SignUpManagerDelegate {
    
    @IBOutlet weak var cardView: PoiView!
    @IBAction func dislikeBtn(_ sender: UIButton) {
        cardView.swipeCurrentCard(to: .left)
    }
    @IBAction func likeBtn(_ sender: UIButton) {
        cardView.swipeCurrentCard(to: .right)
    }
    
    var signUpManager = SignUpManager()
    var prefArray: [SignUpModel] = []
    var sampleCards = [UIView]()
    var interestsArr:[String] = []
    var count = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpManager.delegate = self
            signUpManager.fetchSignUp(interestsArr)
        cardView.delegate = self
    }
    
    func didUpdateSignUp(_ SignUpManager: SignUpManager, SignUp: [SignUpModel]) {
        count += 1
        DispatchQueue.main.async {
            self.prefArray = SignUp
            for i in self.prefArray {
                let card = UIView(frame: CGRect(x: 20, y: 113, width: 374, height: 634))

                let title = UILabel(frame: CGRect(x: 0, y: 424, width: 354, height: 140))
                title.attributedText = self.outline(string: i.title, font: "gidole", size: 30, outlineSize: 3, textColor: UIColor(red: 239/255, green: 250/255, blue: 211/255, alpha: 1), outlineColor: .orange)
                title.numberOfLines = 0
                title.textAlignment = .right

                let genre = UILabel(frame: CGRect(x: 0, y: 564, width: 354, height: 20))
                genre.text = i.title
                genre.textColor = UIColor(red: 239/255, green: 250/255, blue: 211/255, alpha: 1)
                genre.textAlignment = .right
                genre.font = UIFont(name: "gidole", size: 18)

                let year = UILabel(frame: CGRect(x: 0, y: 584, width: 354, height: 20))
                year.text = i.year
                year.textColor = UIColor(red: 239/255, green: 250/255, blue: 211/255, alpha: 1)
                year.textAlignment = .right
                year.font = UIFont(name: "gidole", size: 18)

                let imageURL: URL = URL(string: "https://image.tmdb.org/t/p/w500/\(i.poster_path)")!
                (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in

                    if let data = imageData {
                        print("Did download image data")

                        DispatchQueue.main.async {
                            UIGraphicsBeginImageContext(card.frame.size)
                            UIImage(data: data)?.draw(in: card.bounds)

                            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                                UIGraphicsEndImageContext()
                                card.backgroundColor = UIColor(patternImage: image)
                            }else{
                                UIGraphicsEndImageContext()
                                debugPrint("Image not available")
                             }
                        }
                    }
                }).resume()

                card.addSubview(title)
                card.addSubview(genre)
                card.addSubview(year)
                card.layer.cornerRadius = 15
                self.sampleCards.append(card)
            }
            print(SignUpManager.count, "ddsjkfldshgd")
            print(self.count, "eeeeeeee")
            if self.count == SignUpManager.count {self.cardView.dataSource = self}
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }


    
    
    func numberOfCards(_ poi: PoiView) -> Int {
        return sampleCards.count
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

    
    
    
    func outline(string:String, font:String, size:CGFloat, outlineSize:Float, textColor:UIColor, outlineColor:UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string:string,
                                         attributes: outlineAttributes(font: UIFont(name: font, size: size)!,
                                                            outlineSize: outlineSize, textColor: textColor, outlineColor: outlineColor))
    }

    func outlineAttributes(font: UIFont, outlineSize: Float, textColor: UIColor, outlineColor: UIColor) -> [NSAttributedString.Key: Any]{
        return [
            NSAttributedString.Key.strokeColor : outlineColor,
            NSAttributedString.Key.foregroundColor : textColor,
            NSAttributedString.Key.strokeWidth : -outlineSize,
            NSAttributedString.Key.font : font
        ]
    }
    
    
}

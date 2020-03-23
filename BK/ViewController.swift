//
//  ViewController.swift
//  BK
//
//  Created by Slava Pashaliuk on 3/21/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import UIKit
//import SwiftyGif
//
//class LogoAnimationView: UIView {
//
//    let logoGifImageView = UIImageView(gifImage: UIImage(gifName: "Animation.gif"), loopCount: 1)
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    func pinEdgesToSuperView() {
//        guard let superView = superview else { return }
//        translatesAutoresizingMaskIntoConstraints = false
//        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
//        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
//        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
//        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
//    }
//
//    private func commonInit() {
//        addSubview(logoGifImageView)
//        backgroundColor = UIColor(red: 255/255, green: 224/255, blue: 192/255, alpha: 1.0)
//        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
//        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        logoGifImageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
//        logoGifImageView.heightAnchor.constraint(equalToConstant: 108).isActive = true
//    }
//}
//
//class ViewController: UIViewController {
//
//    let logoAnimationView = LogoAnimationView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.hideKeyboardWhenTappedAround()
//        view.addSubview(logoAnimationView)
//        logoAnimationView.pinEdgesToSuperView()
//        logoAnimationView.logoGifImageView.delegate = self
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        logoAnimationView.logoGifImageView.startAnimatingGif()
//    }
//
//}
//
//extension ViewController: SwiftyGifDelegate {
//    func gifDidStop(sender: UIImageView) {
//        logoAnimationView.isHidden = true
//    }
//}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}


//
//  UIAnimatable.swift
//  DoListApp
//
//  Created by YANA on 08/03/2022.
//

import Foundation
import Lottie

protocol UIAnimatable where Self: UIViewController {
    
    func showAnimation(animation:String)
    
}

extension UIAnimatable{
    func showAnimation(animation: String){
        let animationView = AnimationView()
        animationView.animation = Animation.named(animation)
        animationView.contentMode = .center
        animationView.frame = view.bounds
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        view.addSubview(animationView)
    }
    
}

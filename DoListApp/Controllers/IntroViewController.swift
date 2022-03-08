//
//  IntroViewController.swift
//  DoListApp
//
//  Created by YANA on 05/03/2022.
//

import UIKit
import Lottie

class IntroViewController: UIViewController, UIAnimatable {

    private var appTitle: UILabel =  {
        let label = UILabel()
        label.text = "DO TODAY"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(appTitle)
        showAnimation(animation: "intro")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: setView)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appTitle.center.x = view.center.x
        appTitle.center.x -= view.bounds.width
        // animate it from the left to the right
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.appTitle.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        self.view.bringSubviewToFront(appTitle)
       
        
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appTitle.frame = CGRect(x: 20, y: view.bounds.height / 1.5, width: view.frame.size.width - 20,
                                height: view.frame.height / 9)
 
    }
    
   
    private func setView(){
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
         nextViewController.modalPresentationStyle = .fullScreen
         self.present(nextViewController, animated:true, completion:nil)
     }
    
    

}

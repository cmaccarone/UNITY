//
//  Extensions.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/28/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    func addLoadingIconInMiddleOfScreen(startAnimating: Bool){
        let backView = UIView()
        backView.isHidden = true
        let loadingView = UIActivityIndicatorView()
        let backViewFrame = CGRect(x: self.view.frame.midX - 20, y: self.view.frame.midY - 20, width: 40, height: 40)
        backView.frame = backViewFrame
        backView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        backView.layer.cornerRadius = 20
        backView.alpha = 0.50
        
        loadingView.hidesWhenStopped = true
        loadingView.style = .whiteLarge
        loadingView.center = self.view.center
        self.view.addSubview(backView)
        self.view.addSubview(loadingView)
        backView.isHidden = false
        loadingView.startAnimating()
        
        
       
        
        
        if startAnimating {
            
            
            
        } else if !startAnimating {
            
         
//            backView.removeFromSuperview()
            print("removed")
        }
        
    }
}

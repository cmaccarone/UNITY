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
   
    
    func startAnimating(size: LoadingViewSize){
        
        let backView = UIView()
        let loadingView = UIActivityIndicatorView()
        let theSize = size.rawValue
        backView.isHidden = true
        backView.tag = 996709
        loadingView.tag = 996708
        
        let backViewFrame = CGRect(x: Double(self.view.frame.midX) - (theSize / 2), y: Double(self.view.frame.midY) - (theSize / 2), width: theSize, height: theSize)
        backView.frame = backViewFrame
        backView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        backView.layer.cornerRadius = CGFloat(theSize / 2)
        backView.alpha = 0.50
        loadingView.hidesWhenStopped = true
        loadingView.style = .whiteLarge
        loadingView.center = self.view.center
        self.view.addSubview(backView)
        self.view.addSubview(loadingView)
        backView.isHidden = false
        loadingView.startAnimating()
    }
    
    func stopAnimating() {
        
        let loadingView = self.view.viewWithTag(996708) as! UIActivityIndicatorView
        let backView = self.view.viewWithTag(996709)
        loadingView.hidesWhenStopped = true
        loadingView.stopAnimating()
        backView?.removeFromSuperview()
        loadingView.removeFromSuperview()
        
    }
    
    func deleteImage(named: String) {
        if let directory = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            do {
                try FileManager.default.removeItem(at: URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(named))
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func saveImage(image: UIImage,named: String) {
        guard let data = image.jpegData(compressionQuality: 1) else {
            return
        }
        guard let directory = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) as NSURL else {
           return
        }
        do {
            try data.write(to: directory.appendingPathComponent(named)!)
            
        } catch {
            print(error.localizedDescription)
            
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
}

enum LoadingViewSize : Double {
    case small = 40
    case medium = 80
    case large = 120
}

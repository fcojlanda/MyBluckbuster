//
//  UIViewExtensions.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 27/07/21.
//

import Foundation
import UIKit

extension UIView {
    func loadNIB()-> UIView {
        let bundle = Bundle(for: type(of: self))
        let name = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: name, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

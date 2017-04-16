//
//  AutoLayoutUIView.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 14/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

extension UIView {
    
    func constraintTo(top: NSLayoutYAxisAnchor?, topConstant: CGFloat?, bottom: NSLayoutYAxisAnchor?, bottomConstant: CGFloat?, left: NSLayoutXAxisAnchor?, leftConstant: CGFloat?, right: NSLayoutXAxisAnchor?, rightConstant: CGFloat?, widthConstant: CGFloat?, heightConstant: CGFloat?) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        if let top = top {
            constraints.append(self.topAnchor.constraint(equalTo: top, constant: topConstant ?? 0))
        }
        
        if let bottom = bottom {
            constraints.append(self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant ?? 0))
        }
        
        if let left = left {
            constraints.append(self.leftAnchor.constraint(equalTo: left, constant: leftConstant ?? 0))
        }
        
        if let right = right {
            constraints.append(self.rightAnchor.constraint(equalTo: right, constant: rightConstant ?? 0))
        }
        
        if let widthConstant = widthConstant {
            constraints.append(self.widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if let heightConstant = heightConstant {
            constraints.append(self.heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        constraints.forEach{ $0.isActive = true }
    }
}

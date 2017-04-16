//
//  HomeCollectionViewFooterCell.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 14/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

class HomeCollectionViewFooterCell: UICollectionViewCell {
    
    let paddingWhiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "More suggestions"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = twitterBlue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        addFooterLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addFooterLabel() {
        self.addSubview(paddingWhiteView)
        self.addSubview(footerLabel)
        
        paddingWhiteView.constraintTo(top: self.topAnchor, topConstant: nil, bottom: self.bottomAnchor, bottomConstant: -10, left: self.leftAnchor, leftConstant: 0, right: self.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: nil)
        footerLabel.constraintTo(top: paddingWhiteView.topAnchor, topConstant: nil, bottom: paddingWhiteView.bottomAnchor, bottomConstant: nil, left: paddingWhiteView.leftAnchor, leftConstant: 12, right: paddingWhiteView.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: nil)
    }
}

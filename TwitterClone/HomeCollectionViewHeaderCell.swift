//
//  HomeCollectionViewHeaderCell.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 14/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

class HomeCollectionViewHeaderCell: UICollectionViewCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "WHO TO  FOLLOW"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let separatorLine: UIView = {
        let saparatorLine = UIView()
        saparatorLine.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return saparatorLine
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        addHeaderLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addHeaderLabel() {
        self.addSubview(headerLabel)
        self.addSubview(separatorLine)
        
        headerLabel.constraintTo(top: self.topAnchor, topConstant: nil, bottom: separatorLine.topAnchor, bottomConstant: nil, left: self.leftAnchor, leftConstant: 12, right: self.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: nil)
        separatorLine.constraintTo(top: nil, topConstant: nil, bottom: self.bottomAnchor, bottomConstant: nil, left: self.leftAnchor, leftConstant: nil, right: self.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: 1)
    }
}

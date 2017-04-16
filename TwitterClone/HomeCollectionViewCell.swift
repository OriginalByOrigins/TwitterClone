//
//  HomeCollectionViewCell.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 14/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

let twitterBlue = UIColor(red: 61/255, green: 167/255, blue: 244/255, alpha: 1)

class HomeCollectionViewCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            guard let url = URL(string: user!.profileImageUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil { return }
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data) ?? #imageLiteral(resourceName: "default_image")
                }
            }.resume()
            
            nameLabel.text = user?.name
            userNameLabel.text = user?.userName
            bioTextView.text = user?.bioText
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        return label
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.isSelectable = false
        return textView
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = twitterBlue.cgColor
        button.layer.borderWidth = 1.5
        button.setImage( #imageLiteral(resourceName: "follow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return button
    }()
    
    let separatorLine: UIView = {
        let saparatorLine = UIView()
        saparatorLine.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return saparatorLine
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        addComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeCollectionViewCell {
    
    func addComponents() {
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        self.addSubview(userNameLabel)
        self.addSubview(bioTextView)
        self.addSubview(followButton)
        self.addSubview(separatorLine)
        
        profileImageView.constraintTo(top: self.topAnchor, topConstant: 8, bottom: nil, bottomConstant: nil, left: self.leftAnchor, leftConstant: 12, right: nil, rightConstant: nil, widthConstant: 45, heightConstant: 45)
        
        nameLabel.constraintTo(top: profileImageView.topAnchor, topConstant: nil, bottom: nil, bottomConstant: nil, left: profileImageView.rightAnchor, leftConstant: 8, right: followButton.leftAnchor, rightConstant: -15, widthConstant: nil, heightConstant: 17)
        
        userNameLabel.constraintTo(top: nameLabel.bottomAnchor, topConstant: nil, bottom: nil, bottomConstant: nil, left: nameLabel.leftAnchor, leftConstant: nil, right: nameLabel.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: 20)
        
        bioTextView.constraintTo(top: userNameLabel.bottomAnchor, topConstant: -4, bottom: separatorLine.topAnchor, bottomConstant: nil, left: nameLabel.leftAnchor, leftConstant: -4, right: self.rightAnchor, rightConstant: -8, widthConstant: nil, heightConstant: nil)
        
        followButton.constraintTo(top: profileImageView.topAnchor, topConstant: nil, bottom: nil, bottomConstant: nil, left: nil, leftConstant: nil, right: self.rightAnchor, rightConstant: -25, widthConstant: 115, heightConstant: 30)
        
        separatorLine.constraintTo(top: nil, topConstant: nil, bottom: self.bottomAnchor, bottomConstant: nil, left: self.leftAnchor, leftConstant: nil, right: self.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: 1)
    }
}




















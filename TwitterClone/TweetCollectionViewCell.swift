//
//  TweetCollectionViewCell.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 15/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

class TweetCollectionViewCell: UICollectionViewCell {
    
    var tweet: Tweet? {
        didSet {
            guard let url = URL(string: tweet!.user.profileImageUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil { return }
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data) ?? #imageLiteral(resourceName: "default_image")
                }
            }.resume()
            
            
            let name = tweet?.user.name
            let userName = tweet?.user.userName
            let message = tweet?.message
            
            let attributedText = NSMutableAttributedString(string: name!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)])
            attributedText.append(NSAttributedString(string: "  \(userName ?? "")\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let range = NSMakeRange(0, attributedText.string.characters.count)
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
            
            attributedText.append(NSAttributedString(string: message!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]))
            
            displayedTextView.attributedText = attributedText
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let displayedTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isSelectable = false
        return textView
    }()
    
    let bottomBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let replyButtonContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "reply").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let retweetButtonContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "retweet").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let likeButtonContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let sendMessageButtonContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send_message").withRenderingMode(.alwaysOriginal), for: .normal)
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

extension TweetCollectionViewCell {
    
    fileprivate func addComponents() {
        self.addSubview(profileImageView)
        self.addSubview(displayedTextView)
        self.addSubview(bottomBarStackView)
        self.addSubview(separatorLine)
        
        profileImageView.constraintTo(top: self.topAnchor, topConstant: 12, bottom: nil, bottomConstant: nil, left: self.leftAnchor, leftConstant: 12, right: nil, rightConstant: nil, widthConstant: 45, heightConstant: 45)
        
        displayedTextView.constraintTo(top: self.topAnchor, topConstant: 2, bottom: bottomBarStackView.topAnchor, bottomConstant: nil, left: profileImageView.rightAnchor, leftConstant: 8, right: self.rightAnchor, rightConstant: -8, widthConstant: nil, heightConstant: nil)
        
        bottomBarStackView.constraintTo(top: nil, topConstant: nil, bottom: separatorLine.topAnchor, bottomConstant: nil, left: displayedTextView.leftAnchor, leftConstant: 4, right: displayedTextView.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: 20)
        
        addButtonsToBottomBar()
        
        separatorLine.constraintTo(top: nil, topConstant: nil, bottom: self.bottomAnchor, bottomConstant: nil, left: self.leftAnchor, leftConstant: nil, right: self.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: 1)
    }
    
    fileprivate func addButtonsToBottomBar() {
        bottomBarStackView.addArrangedSubview(replyButtonContainerView)
        bottomBarStackView.addArrangedSubview(retweetButtonContainerView)
        bottomBarStackView.addArrangedSubview(likeButtonContainerView)
        bottomBarStackView.addArrangedSubview(sendMessageButtonContainerView)
        
        self.addSubview(replyButton)
        self.addSubview(retweetButton)
        self.addSubview(likeButton)
        self.addSubview(sendMessageButton)
        
        replyButton.constraintTo(top: replyButtonContainerView.topAnchor, topConstant: nil, bottom: replyButtonContainerView.bottomAnchor, bottomConstant: nil, left: replyButtonContainerView.leftAnchor, leftConstant: nil, right: nil, rightConstant: nil, widthConstant: 20, heightConstant: nil)
        
        retweetButton.constraintTo(top: retweetButtonContainerView.topAnchor, topConstant: nil, bottom: retweetButtonContainerView.bottomAnchor, bottomConstant: nil, left: retweetButtonContainerView.leftAnchor, leftConstant: nil, right: nil, rightConstant: nil, widthConstant: 20, heightConstant: nil)
        
        likeButton.constraintTo(top: likeButtonContainerView.topAnchor, topConstant: nil, bottom: likeButtonContainerView.bottomAnchor, bottomConstant: nil, left: likeButtonContainerView.leftAnchor, leftConstant: nil, right: nil, rightConstant: nil, widthConstant: 20, heightConstant: nil)
        
        sendMessageButton.constraintTo(top: sendMessageButtonContainerView.topAnchor, topConstant: nil, bottom: sendMessageButtonContainerView.bottomAnchor, bottomConstant: nil, left: sendMessageButtonContainerView.leftAnchor, leftConstant: nil, right: nil, rightConstant: nil, widthConstant: 20, heightConstant: nil)
    }
}

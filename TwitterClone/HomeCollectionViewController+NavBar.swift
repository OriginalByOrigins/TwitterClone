//
//  HomeCollectionViewController+NavBar.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 15/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

extension HomeCollectionViewController {
    
    func setUpNavBar() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        setUpBarTitleItem()
        setUpLeftBarItems()
        setUpRightBarItems()
    }
    
    private func setUpBarTitleItem() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "title_icon").withRenderingMode(.alwaysOriginal))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    private func setUpLeftBarItems() {
        let followButton = UIButton(type: .system)
        followButton.setImage(#imageLiteral(resourceName: "follow").withRenderingMode(.alwaysOriginal), for: .normal)
        followButton.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        followButton.contentMode = .scaleAspectFit
        let followButtonItem = UIBarButtonItem(customView: followButton)
        
        self.navigationItem.leftBarButtonItems = [followButtonItem]
    }
    
    private func setUpRightBarItems() {
        let composeButton = UIButton(type: .system)
        composeButton.setImage(#imageLiteral(resourceName: "compose").withRenderingMode(.alwaysOriginal), for: .normal)
        composeButton.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        composeButton.contentMode = .scaleAspectFit
        let composeButtonItem = UIBarButtonItem(customView: composeButton)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        searchButton.contentMode = .scaleAspectFit
        let searchButtonItem = UIBarButtonItem(customView: searchButton)
        
        self.navigationItem.rightBarButtonItems = [composeButtonItem ,searchButtonItem]
    }
}

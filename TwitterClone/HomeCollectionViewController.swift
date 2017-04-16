//
//  HomeCollectionViewController.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 14/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

private let homeCellID = "HomeCellID"
private let homeHeaderID = "HomeHeaderID"
private let homeFooterID = "HomeFooterID"
private let tweetCellID = "TweetCellID"

class HomeCollectionViewController: UICollectionViewController{
    
    var users: [User]?
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        
        self.collectionView?.backgroundColor = UIColor(red: 232/255, green: 236/255, blue: 241/255, alpha: 1)
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.bounces = true
        self.collectionView?.showsVerticalScrollIndicator = false

        // Register cell classes
        self.collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: homeCellID)
        self.collectionView?.register(HomeCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: homeHeaderID)
        self.collectionView?.register(HomeCollectionViewFooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: homeFooterID)
        self.collectionView!.register(TweetCollectionViewCell.self, forCellWithReuseIdentifier: tweetCellID)
        
        // Do any additional setup after loading the view.
        
        let errorMessageLabel: UILabel = {
            let label = UILabel()
            label.text = "Oops, somethings went wrong. Please try again later..."
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        Service.sharedInsance.fetchHomeFeed { (fetchedData, fetchedError) in
            if let fetchedError = fetchedError {
                displayErrorMessage()
                if let apiError = fetchedError as? APIError<Service.FetchedError> {
                    errorMessageLabel.text = apiError.response?.statusCode == 200 ? errorMessageLabel.text : "No internet connection. Please try again..."
                }
                return
            }
            
            self.users = fetchedData?.users
            self.tweets = fetchedData?.tweets
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        
        func displayErrorMessage() {
            self.view?.addSubview(errorMessageLabel)
            errorMessageLabel.constraintTo(top: self.view.topAnchor, topConstant: nil, bottom: self.view.bottomAnchor, bottomConstant: nil, left: self.view.leftAnchor, leftConstant: nil, right: self.view.rightAnchor, rightConstant: nil, widthConstant: nil, heightConstant: nil)
        }
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionViewLayout.invalidateLayout()
    }
}

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? users?.count ?? 0 : tweets?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let followCell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellID, for: indexPath) as! HomeCollectionViewCell
            followCell.user = users?[indexPath.item]
            return followCell
        } else {
            let tweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: tweetCellID, for: indexPath) as! TweetCollectionViewCell
            tweetCell.tweet = tweets?[indexPath.item]
            return tweetCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        func estimateHeight(forString text: String, ofSize size: CGFloat) -> CGFloat {
            let widthOfBioTextView = self.view.frame.width - 12 - 45 - 8 - 8 - 3
            let approximatedSize = CGSize(width: widthOfBioTextView, height: 1000)
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: size)]
            let estimatedFrame = NSString(string: text).boundingRect(with: approximatedSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return estimatedFrame.height
        }
        
        if indexPath.section == 0 {
            guard let user = users?[indexPath.item] else { return .zero }
            
            let estimatedHeight = estimateHeight(forString: user.bioText, ofSize: 14)
            let cellHeight = estimatedHeight + 8 + 17 + 20 - 4 + 1 + 17
            return CGSize(width: self.view.frame.width, height: cellHeight)
            
        } else {
            guard let tweet = tweets?[indexPath.item] else { return .zero }
            
            let estimatedHeight = estimateHeight(forString: tweet.message, ofSize: 15)
            let cellHeight = estimatedHeight + 2 + 30 + 12 + 1 + 17
            return CGSize(width: self.view.frame.width, height: cellHeight)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

extension HomeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: homeHeaderID, for: indexPath)
            return headerCell
        } else {
            let footerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: homeFooterID, for: indexPath)
            return footerCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? users?.count ?? 0 > 0 ? CGSize(width: self.view.frame.height, height: 50) : .zero : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section == 0 ? users?.count ?? 0 > 0 ? CGSize(width: self.view.frame.height, height: 50) : .zero : .zero
    }
}

extension HomeCollectionViewController {
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

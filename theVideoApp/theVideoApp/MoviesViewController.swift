//
//  MoviesViewController.swift
//  theVideoApp
//
//  Created by Matheus Amancio Seixeiro on 5/4/16.
//  Copyright © 2016 Matheus Amancio Seixeiro. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var collectionView1 : UICollectionView!
    let reuseIdentifierFeatured = "FeaturedCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollView!.contentSize = CGSizeMake(1920, 2200)
    }
    
    // Collection View Methods
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 50.0)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (collectionView == self.collectionView1)
        {
            return 8
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.collectionView1)
        {
            let cell : FeaturedCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifierFeatured, forIndexPath: indexPath) as! FeaturedCollectionViewCell
            
            let  imageFilename = "feature-\(indexPath.row).jpg"
            cell.featuredImage.image = UIImage(named: imageFilename)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let playerVC = PlayerViewController()
        playerVC.playVideo()
        [self.presentViewController(playerVC, animated: true, completion: nil)]
    }
    
}

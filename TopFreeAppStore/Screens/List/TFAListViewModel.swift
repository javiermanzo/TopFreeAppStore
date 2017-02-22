//
//  TFAListViewModel.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/19/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
import AICustomViewControllerTransition

class TFAListViewModel {
    
    enum UIUserInterfaceIdiom : Int {
        case unspecified
        case phone // iPhone and iPod touch style UI
        case pad // iPad style UI
    }
    
    var customTransitioningDelegate: InteractiveTransitioningDelegate = InteractiveTransitioningDelegate()
    
    var lastPanRatio: CGFloat = 0.0
    let panRatioThreshold: CGFloat = 0.3
    var lastDetailViewOriginY: CGFloat = 0.0
    
    lazy var appsList: Results<TFAApp> = { TFARealmHelper.shared.realm.objects(TFAApp.self) }()
    
    func setListData(list: Any) {
        self.appsList = (list as? Results<TFAApp>)!
    }
    
    func getCellIdentifier() -> String {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return TFAListiPadCollectionViewCell.id
        } else {
            return TFAListCollectionViewCell.id
        }
        
    }
    
    func getCellNib() -> UINib {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return TFAListiPadCollectionViewCell.cellNib
        } else {
            return TFAListCollectionViewCell.cellNib
        }
    }
    
    func getCellSize() -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 180, height: 180)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        }
    }
    
    func fillCellData(cell: UICollectionViewCell, app: TFAApp) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let collectionViewCell = cell as! TFAListiPadCollectionViewCell
            collectionViewCell.titleLabel.text = app.title
            collectionViewCell.categoryLabel.text = app.category.name
            collectionViewCell.logoImageView.kf.setImage(with: URL(string: app.imageUrl), placeholder: UIImage(named:"image-holder"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        } else {
            let collectionViewCell = cell as! TFAListCollectionViewCell
            collectionViewCell.titleLabel.text = app.title
            collectionViewCell.categoryLabel.text = app.category.name
            
            collectionViewCell.logoImageView.kf.setImage(with: URL(string: app.imageUrl), placeholder: UIImage(named:"image-holder"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
            
        }
    }
    
    func getAppDetailsViewController() -> TFAppDetailsViewController {
        
        let storyboard: UIStoryboard!
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            storyboard = UIStoryboard(storyboard: .MainiPad)
        } else {
            storyboard = UIStoryboard(storyboard: .Main)
        }
        
        let vc: TFAppDetailsViewController = storyboard.instantiateViewController()
        
        return vc
    }
    
    func configutreTransition() {
        self.customTransitioningDelegate.transitionDismiss = { (fromViewController: UIViewController, toViewController: UIViewController, containerView: UIView, transitionType: TransitionType, completion: @escaping () -> Void) in
            
            UIView.animate(withDuration: defaultTransitionAnimationDuration, animations: {
                
                fromViewController.view.alpha = 0.0
                
            }, completion: { (finished) in
                completion()
                // Reset value, since we are using a lazy var for viewController
                fromViewController.view.alpha = 1.0
            })
        }
    }
    
    func getPanGestureRecognizer(originView: UIView, destinationVC: UIViewController) -> ((_ panGestureRecognizer: UIPanGestureRecognizer) -> Void) {
        
        var handlePan: ((_ panGestureRecognizer: UIPanGestureRecognizer) -> Void)
        
        handlePan = {(panGestureRecozgnizer) in
            
            let translatedPoint = panGestureRecozgnizer.translation(in: originView)
            
            if (panGestureRecozgnizer.state == .began) {
                // Begin dismissing view controller
                self.customTransitioningDelegate.beginDismissing(viewController: destinationVC)
                self.lastDetailViewOriginY = destinationVC.view.frame.origin.y
                
            } else if (panGestureRecozgnizer.state == .changed) {
                let ratio = (self.lastDetailViewOriginY + translatedPoint.y) / destinationVC.view.bounds.height
                // Store lastPanRatio for next callback
                self.lastPanRatio = ratio
                
                // Update percentage of interactive transition
                self.customTransitioningDelegate.update(self.lastPanRatio)
            } else if (panGestureRecozgnizer.state == .ended) {
                // If pan ratio exceeds the threshold then transition is completed, otherwise cancel dismissal and present the view controller again
                let completed = (self.lastPanRatio > self.panRatioThreshold) || (self.lastPanRatio < -self.panRatioThreshold)
                self.customTransitioningDelegate.finalizeInteractiveTransition(isTransitionCompleted: completed)
            }
        }
        return handlePan
    }
}

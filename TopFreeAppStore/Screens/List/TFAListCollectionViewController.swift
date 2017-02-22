//
//  TFAListCollectionViewController.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/19/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import AICustomViewControllerTransition

class TFAListCollectionViewController: UICollectionViewController {
    
    var listViewModel = TFAListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top Free Apps"
        
        if( traitCollection.forceTouchCapability == .available){
            registerForPreviewing(with: self, sourceView: self.collectionView!)
        }
        
        self.listViewModel.configutreTransition()
        
        self.collectionView?.register(self.listViewModel.getCellNib(), forCellWithReuseIdentifier: self.listViewModel.getCellIdentifier())
        
        TFARequestHelper.shared.getList(success: { (data) in
            self.listViewModel.setListData(list: data)
            self.collectionView?.reloadData()
        }) { (error) in
            if TFARealmHelper.shared.getAppsList().count > 0{
                self.listViewModel.setListData(list: TFARealmHelper.shared.getAppsList())
                self.collectionView?.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// UICollectionViewDelegate
extension TFAListCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listViewModel.appsList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.listViewModel.getCellIdentifier(), for: indexPath)
        
        let app = self.listViewModel.appsList[indexPath.row]
        
        self.listViewModel.fillCellData(cell: cell, app: app)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.listViewModel.getAppDetailsViewController()
        vc.app = self.listViewModel.appsList[indexPath.row]
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.listViewModel.customTransitioningDelegate

        vc.handlePan = self.listViewModel.getPanGestureRecognizer(originView: self.view, destinationVC: vc)
        
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension TFAListCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.listViewModel.getCellSize()
    }
}

// Force Touch Delegate
extension TFAListCollectionViewController: UIViewControllerPreviewingDelegate{
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = self.collectionView?.indexPathForItem(at: location) else { return nil }
        
        guard let cell = self.collectionView?.cellForItem(at: indexPath) else { return nil }
        
        let vc = self.listViewModel.getAppDetailsViewController()
        vc.app = self.listViewModel.appsList[indexPath.row]
        
        previewingContext.sourceRect = cell.frame
        
        vc.preferredContentSize = CGSize(width: 0.0, height: 350)
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.listViewModel.customTransitioningDelegate
        
        vc.handlePan = self.listViewModel.getPanGestureRecognizer(originView: self.view, destinationVC: vc)
        
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        self.present(viewControllerToCommit, animated: true, completion: nil)
    }
}



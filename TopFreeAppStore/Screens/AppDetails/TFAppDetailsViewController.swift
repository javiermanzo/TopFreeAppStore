//
//  TFAppDetailsViewController.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/20/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import Kingfisher

class TFAppDetailsViewController: UIViewController {
    
    let appDetailsViewModel = TFAAppDetailsViewModel()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var handlePan: ((_ panGestureRecognizer: UIPanGestureRecognizer) -> Void)?
 
    var app: TFAApp! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDetailsViewModel.setStyleAndFillView(controller: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func downloadAction(_ sender: AnyObject) {
        if let url = URL(string: self.app.link), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        self.handlePan?(sender)
    }
    
}

//Force Touch
extension TFAppDetailsViewController {
    override var previewActionItems: [UIPreviewActionItem] {
        
        let download = UIPreviewAction(title: "Download",
                                       style: .default,
                                       handler: { previewAction, viewController in
                                        self.downloadAction(self)
        })
        
        return [download]
    }
}


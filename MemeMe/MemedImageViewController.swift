//
//  MemedImageViewController.swift
//  MemeMe
//
//  Created by IbrahimGamal on 3/9/19.
//  Copyright © 2019 IbrahimGamal. All rights reserved.
//
import Foundation
import UIKit

class MemedImageViewController: UIViewController {

    var meme:Meme!
    @IBOutlet weak var memedImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
         hideTapButton(hide: true)
        memedImageView.image = meme.memedImage
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        hideTapButton(hide: false)
    }
    
    func hideTapButton(hide:Bool)
    {
     tabBarController?.tabBar.isHidden = hide
    }
  

}

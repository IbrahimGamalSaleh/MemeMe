//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by IbrahimGamal on 3/2/19.
//  Copyright © 2019 IbrahimGamal. All rights reserved.
//

import UIKit



class CollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout:UICollectionViewFlowLayout!

    var memes:[Meme]!{
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
        }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SentMemesViewController")

        // Do any additional setup after loading the view.
        setLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView!.reloadData()
    }

    
    func setLayout()
    { let space:CGFloat = 2.0
        let width = (view.frame.size.width - (2 * space)) / 3.0
        let height = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
   
    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCell", for: indexPath) as! SentMemesCell
    
        // Configure the cell
        cell.imageView?.image = memes[indexPath.row].memedImage
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
    
      
        let controller1=storyboard?.instantiateViewController(withIdentifier: "MemedImageViewController") as! MemedImageViewController
            print(memes[indexPath.row])
            controller1.meme=memes[indexPath.row]
        
         navigationController!.pushViewController(controller1, animated: true)
 
        
    }
   
    
   
}

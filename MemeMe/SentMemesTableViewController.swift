//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by IbrahimGamal on 3/9/19.
//  Copyright © 2019 IbrahimGamal. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController  {

    
    var memes:[Meme]!{
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView!.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText+"..."+meme.bottomText
        return cell
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller=storyboard?.instantiateViewController(withIdentifier: "MemedImageViewController") as! MemedImageViewController
     controller.meme=memes[indexPath.row]
     navigationController!.pushViewController(controller, animated: true)
    }
 

}

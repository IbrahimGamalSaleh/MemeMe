//
//  ViewController.swift
//  MemeMe
//
//  Created by IbrahimGamal on 6/16/1440 AH.
//  Copyright © 1440 AH IbrahimGamal. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate ,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var nav: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var cameraButton: UIBarItem!
    @IBOutlet weak var imageView: UIImageView!
    let memeTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.strokeColor:UIColor.black,
                                                             NSAttributedString.Key.foregroundColor: UIColor.white,
                                                             NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                                                             NSAttributedString.Key.strokeWidth: -4.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle(textField: textFieldTop,text:"TOP")
        setStyle(textField: textFieldBottom,text:"BOTTOM")
        cameraButton?.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled=false
    }
    func setStyle(textField: UITextField,text:String)
    {
        textField.delegate=self
        textField.defaultTextAttributes=memeTextAttributes
        textField.textAlignment = .center
        textField.text=text
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    func save() {
        // Create the meme
        let meme = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        showToolNavBar(isHidden: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        showToolNavBar(isHidden: false)
        
        return memedImage
    }
    func showToolNavBar(isHidden:Bool) {
        toolbar.isHidden=isHidden
        nav.isHidden = isHidden
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        textField.text=""
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image=image
        }
        shareButton.isEnabled=true
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        if (sender as AnyObject).tag == 1 {
            openImagePicker(UIImagePickerController.SourceType.photoLibrary)
            
        }
        else{
            openImagePicker(UIImagePickerController.SourceType.camera)
            
        }
    }
    func openImagePicker(_ type: UIImagePickerController.SourceType){
        let nextController=UIImagePickerController()
        nextController.delegate=self
        nextController.sourceType = type
        present(nextController,animated: true,completion: nil)
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        
        let meme=generateMemedImage()
        let controller=UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        self.save()
        controller.completionWithItemsHandler={ (activityType: UIActivity.ActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
            if completed
            {
               // self.save()
                self.initScreen()
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
         present(controller, animated: true, completion: nil)
        
    }
    func initScreen()
    {
        self.textFieldTop.text="TOP"
        self.textFieldBottom.text="BOTTOM"
        self.imageView.image = nil
        
    }
    @IBAction func cancelPressed(_ sender: Any) {
        shareButton.isEnabled=false
      dismiss(animated: true, completion: nil)
            
       
            
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if textFieldBottom.isEditing
        {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}


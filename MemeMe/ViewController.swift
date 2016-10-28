//
//  ViewController.swift
//  MemeMe
//
//  Created by Reinaldo Verdugo on 12/10/16.
//  Copyright © 2016 Reinaldo Verdugo. All rights reserved.
//

import UIKit

struct Meme {
    var text : String;
    var image : UIImage;
    var memedImage : UIImage;
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // ****************************************************
    // Outlets and properties
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    var imagePicker = UIImagePickerController()
    var delegate1 = TextfieldDelegate()
    var delegate2 = TextfieldDelegate()
    
    // ****************************************************
    // UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
            }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    // ****************************************************
    // UIImagePickerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    // ****************************************************
    // Self created functions
    
    @IBAction func pickImage(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickPhoto(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)

    }
    
    func initView () {
        imagePicker.delegate = self
        imageView.contentMode = .scaleAspectFit
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topField.delegate = delegate1
        bottomField.delegate = delegate2
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.black,            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-Bold", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ] as [String : Any]
        topField.defaultTextAttributes = memeTextAttributes
        bottomField.defaultTextAttributes = memeTextAttributes
        topField.textAlignment = .center
        bottomField.textAlignment = .center
    }
    
    func save () {
        let text =  self.topField.text! + " " + self.bottomField.text!
        let meme = Meme(text: text, image: imageView.image!, memedImage: generateMemedImage())
        dismiss(animated: true, completion: nil)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        self.navigationController?.navigationBar.isHidden = true
        toolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        self.navigationController?.navigationBar.isHidden = false
        toolBar.isHidden = false
        
        return memedImage
    }
    
    
    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Notifications
    
    func keyboardWillShow (_ notification : Notification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide (_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification : Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
    func subscribeToKeyboardNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications () {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func shareAction(_ sender: AnyObject) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler =  {
            (activity, success, items, error) in
            
            if (success)
            {
                //For testing
                print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
                
                //Save only in case user didn't cancel out
                self.save()
            }
        }
        present(controller, animated: true, completion: nil)
        
    }
    
    
}


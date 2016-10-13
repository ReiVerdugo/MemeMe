//
//  ViewController.swift
//  MemeMe
//
//  Created by Reinaldo Verdugo on 12/10/16.
//  Copyright © 2016 Reinaldo Verdugo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageView.contentMode = .scaleAspectFit
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickImage(_ sender: AnyObject) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}


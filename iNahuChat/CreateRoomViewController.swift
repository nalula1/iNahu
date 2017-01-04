//
//  CreateRoomViewController.swift
//  iNahuChat
//
//  Created by User on 12/7/16.
//  Copyright © 2016 nahu. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var choosePhotoBtn: UIButton!
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var captionLbl: UITextField!
    
    
    var selectedPhoto: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //For hide
        
        MBProgressHUD.hide(for: self.view, animated: true)
    
    }
    @IBAction func CancelDidTapped(_ sender: AnyObject) { dismiss(animated: true, completion: nil)
    }
    @IBAction func selectPhoto_Didtapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else {
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedPhoto = info [UIImagePickerControllerEditedImage] as? UIImagePickerControllerDelegate as! UIImage?
        photoImg.image = selectedPhoto
        picker.dismiss(animated: true, completion: nil)
    }
    }


  

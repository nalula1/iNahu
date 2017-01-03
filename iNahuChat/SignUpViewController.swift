//
//  SignUpViewController.swift
//  iNahuChat
//
//  Created by User on 12/7/16.
//  Copyright © 2016 nahu. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
  //  imagePicker.delegate = self
    //selected profile image
    var selectedPhoto: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        //set view controller as delegate for uiimagepikercontrolla before handling events
//imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.selectPhoto(tap:)))
        
        tap.numberOfTapsRequired = 1
        profileImage.addGestureRecognizer(tap)
        
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true
        
    }
    //post tap on profile, set imagepick delegate to own self, allow edit
    //set 
    func selectPhoto(tap: UITapGestureRecognizer) {
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        self.imagePicker.sourceType = .camera
        } else {
            self.imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true, completion: nil)
    
    }
@IBAction func CancelDidTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
//_  ?
    
@IBAction func SignUpDidTapped(_ sender: AnyObject) {

        guard let email = emailTextField.text , !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let username = usernameTextField.text , !username.isEmpty
            else {
            return
    }
        
        
        var data = NSData()
        // sign up
        data = UIImageJPEGRepresentation(profileImage.image!, 0.1)! as NSData
    //signing up
    //  MBProgressHUD.show()
    //Start Loading with MBProgressHUD
    let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
    loadingNotification.mode = MBProgressHUDMode.indeterminate
    loadingNotification.label.text = "iNahuChat will return shortly"
    
    DataService.dataService.signUpWith(username: username, email: email, password: password, data: data)
    }
}
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        //image picker delegate
    //no anyObject just any  deprec
    //_   fixed the issue!!!   why?  thouhg it already carried(passed) over
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
            //sets chosen photo to profile photo..   as? = pattern matching(passively)
        //optional ?  or   !   ???
            selectedPhoto = info[UIImagePickerControllerEditedImage] as! UIImage
            profileImage.image = selectedPhoto
        
            picker.dismiss(animated: true, completion: nil)
            //picker.dismissViewControlControllerAnimated(true, completion: nil)
    }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
        }
}

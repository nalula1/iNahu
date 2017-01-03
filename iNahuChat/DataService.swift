//
//  DataService.swift
//  iNahuChat
//
//  Created by User on 12/14/16.
//  Copyright © 2016 nahu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage


//firAuth.user.id

class DataService {
    static let dataService = DataService()
    private var _BASE_REF = FIRDatabase.database().reference()
    var BASE_REF: FIRDatabaseReference {
        return _BASE_REF
    }
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    var fileURL: String!
   
    func signUpWith(username: String, email: String, password: String, data: NSData) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let changeRequest = user?.profileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                print(error.localizedDescription)
                    return
                }
            })
            let filePath = "profileImage/\(user!.uid)"
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            self.storageRef.child(filePath).put(data as Data, metadata: metadata, completion: { (metadata, error) in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
            
                }
                //asoluteString:string  the url string for a receiver as an URL
                self.fileURL = metadata?.downloadURLs![0].absoluteString
                let changeRequestPhoto = user!.profileChangeRequest()
                changeRequestPhoto.photoURL = NSURL(string: self.fileURL) as URL?
                changeRequestPhoto.commitChanges(completion: { (Error) in
                   if let error = error {
                        print(error.localizedDescription)
                        return}else {
                        print("profile updated")
                    }
                    }
                    )
                //Stop Loading
                //For hide
               // MBProgressHUD.hide(for: self.view, animated: true)
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
        } )
        
        })
    }


}

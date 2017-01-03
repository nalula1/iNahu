//
//  CreateRoomViewController.swift
//  iNahuChat
//
//  Created by User on 12/7/16.
//  Copyright © 2016 nahu. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //For hide
        
        MBProgressHUD.hide(for: self.view, animated: true)
    
    }
    @IBAction func CancelDidTapped(_ sender: AnyObject) { dismiss(animated: true, completion: nil)
    }
    }
    

  

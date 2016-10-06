//
//  FeedVC.swift
//  SocialMediaPlatform
//
//  Created by Arron Mollet on 10/6/16.
//  Copyright © 2016 Arron Mollet. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //SIGN OUT AND REMOVE DATA FROM KEYCHAIN.. PRIMARILY FOR DEV PURPOSES

    @IBAction func signOut(_ sender: AnyObject) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
        }
   
}

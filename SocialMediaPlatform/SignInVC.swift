//
//  ViewController.swift
//  SocialMediaPlatform
//
//  Created by Arron Mollet on 10/4/16.
//  Copyright © 2016 Arron Mollet. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //CODE FOR FACEBOOK LOGIN BUTTON -- CONNECTED DIRECTLY TO FACEBOOK BUTTON
    
    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unabable to authenticate with Facebook")
            } else if result?.isCancelled == true {
                print("User cancled Facebook authentication")
            } else {
                print("Succesfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
                
            }
        }
        
    }
    
    //FUNC FOR FIREBASE LOGIN USED FOR FACEBOOK AS WELL AS FIREBASE LOGIN
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase")
            } else {
                print("Successfully authenticated with Firebase")
            }
            
        })
    }
    
    //IBACTION FOR LOGIN WITH EMAIL/PASSWORD FOR FIREBASE

    @IBAction func SignInTapped(_ sender: AnyObject) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Emial user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error == nil {
                            print("Unable to authenticate with Firebase Email")
                        } else {
                            print("Succesfully authenticated with Firesbase")
                        }
                    })
                }
            })
        }
        
        
        
        
    }
}


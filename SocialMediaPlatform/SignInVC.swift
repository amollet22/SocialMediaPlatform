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
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    //CODE TO AUTO LOGIN WITH KEYCHAINWRAPPER
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
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
                
    //CODE FOR ADDING KEYCHAIN FEATURE FOR AUTO LOGIN -- MUST ADD KEYCHAINWRAPPER POD
                
                if let user = user {
                self.completeSignIn(id: user.uid)
                }
            }
                
            
        })
    }
    
    //IBACTION FOR LOGIN WITH EMAIL/PASSWORD FOR FIREBASE

    @IBAction func SignInTapped(_ sender: AnyObject) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Emial user authenticated with Firebase")
                    
    //CODE FOR ADDING KEYCHAIN FEATURE FOR AUTO LOGIN -- MUST ADD KEYCHAINWRAPPER POD
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
    //----------------------------------------------------------------------------------
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error == nil {
                            print("Unable to authenticate with Firebase Email")
                        } else {
                            print("Succesfully authenticated with Firesbase")
                            
    //CODE FOR ADDING KEYCHAIN FEATURE FOR AUTO LOGIN -- MUST ADD KEYCHAINWRAPPER POD
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                            
    //-----------------------------------------------------------------------------------

                        }
                    })
                }
            })
        }
        
    }
    
    //FUNC FOR ADDING KEYCHAIN FEATURE FOR AUTO LOGIN -- MUST ADD KEYCHAINWRAPPER POD
    
    func completeSignIn(id: String) {
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data saved to keychain")
        performSegue(withIdentifier: "goToFeed", sender: nil)
        
    }
    
}













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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var settings: DropDownView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SETUP FOR TABLE VIEW
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: ANIMATED INTRO SCREEN
        
        settings = Bundle.main.loadNibNamed("DropDown", owner: self, options: nil)?.last as! DropDownView
        settings.frame = CGRect(x: 0, y: -444, width: view.frame.size.width, height: 590)
        
        self.view.addSubview(settings)
        settings.setup()

        
        
    }
    
    
    
    //FUNCS FOR UITABLEVIEW
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    



    //SIGN OUT AND REMOVE DATA FROM KEYCHAIN.. PRIMARILY FOR DEV PURPOSES

    @IBAction func signOut(_ sender: AnyObject) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
        }
   
    @IBAction func newPostTapped(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "goToPostPage", sender: nil)
    }
    
}

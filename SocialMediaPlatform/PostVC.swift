//
//  PostVC.swift
//  SocialMediaPlatform
//
//  Created by Arron Mollet on 10/7/16.
//  Copyright © 2016 Arron Mollet. All rights reserved.
//

import UIKit



class PostVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backToFeed(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

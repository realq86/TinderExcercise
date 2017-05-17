//
//  ProfileViewController.swift
//  TinderExcercise
//
//  Created by Developer on 4/29/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var fakeNavigationBar: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var profileImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.profileImageView.image = profileImage
        
        let tapGesture = UITapGestureRecognizer(target:self, action:#selector(userDidTapOnFakeNavi))
        
        self.fakeNavigationBar.addGestureRecognizer(tapGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func userDidTapOnFakeNavi() {
        self.dismiss(animated: true) { 
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

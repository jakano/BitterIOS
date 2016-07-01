//
//  ProfileViewController.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/30/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var followNumLabel: UILabel!

    @IBOutlet weak var followerNumLabel: UILabel!
    @IBOutlet weak var tweetNumLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

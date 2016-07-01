//
//  YourProfileViewController.swift
//  Bitter
//
//  Created by Jedidiah Akano on 7/1/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit

class YourProfileViewController: UIViewController {
    
    var user: User!

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var followingNumLabel: UILabel!
    @IBOutlet weak var followerNumLabel: UILabel!
    @IBOutlet weak var tweenNumLabel: UILabel!
    @IBOutlet weak var screennameView: UILabel!
    @IBOutlet weak var nameHandelView: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User.currentUser
        let followerCount = user.followersCount
        print(followerCount)
        let followingCount = user.followingCount
        let tweetCount = user.statusCount
        let screename = user.screenName
        let name = user.name
        let profileUrl = user.profileUrl
        let info = user.info
        var backGroundImageUrl = user.profileBackgroundUrl
        followerNumLabel.text = String(followerCount)
        followingNumLabel.text = String(followingCount)
        tweenNumLabel.text = String(tweetCount)
        screennameView.text = "@\(screename!)"
        nameHandelView.text = name
        profileImageView.setImageWithURL(profileUrl!)
        infoLabel.text = info
        if backGroundImageUrl == nil {
            backgroundImageView.hidden = true
        } else {
            print("got em 2")
        
        backgroundImageView.setImageWithURL(backGroundImageUrl!)
        }
        
        
        

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

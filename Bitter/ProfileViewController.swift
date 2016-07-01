//
//  ProfileViewController.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/30/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
   
    var tweet: Tweet!
    var retweetCounter = 0
    var favoriteCounter = 0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followNumLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var followerNumLabel: UILabel!
    @IBOutlet weak var tweetNumLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = tweet.user!.name
        let followers = tweet.user!.followersCount
        let following = tweet.user!.followingCount
        let profileUrl = tweet.user!.profileUrl
        let screenname = tweet.user!.screenName
        let tweetCount = tweet.user!.statusCount
        profileImageView.setImageWithURL(profileUrl!)
        nameLabel.text = name
        followNumLabel.text = String(following)
        followerNumLabel.text = String(followers)
        screennameLabel.text = "@\(screenname)"
        tweetNumLabel.text = String(tweetCount)

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

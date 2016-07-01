//
//  DetailViewController.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/30/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var tweet: Tweet!
    var retweetCounter = 0
    var favoriteCounter = 0

    @IBOutlet weak var detailsFavoriteCountLabel: UILabel!
    @IBOutlet weak var detailsRetweetCountLabel: UILabel!
    @IBOutlet weak var detailsTweetLabel: UILabel!
    @IBOutlet weak var detailsHandleLabel: UILabel!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsProfileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tweet)
        let name = tweet.user!.name
        let screenName = tweet.user!.screenName
        let tweetText = tweet.text
        let favoriteCount = tweet.favoritesCount
        let retweetCount = tweet.retweetCount
        let profileUrl = tweet.user!.profileUrl
        
        detailsNameLabel.text = name
        detailsHandleLabel.text = "@\(screenName)"
        detailsTweetLabel.text = tweetText
        detailsFavoriteCountLabel.text = String(favoriteCount)
        detailsRetweetCountLabel.text = String(retweetCount)
        detailsProfileImageView.setImageWithURL(profileUrl!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onDetailsRetweet(sender: AnyObject) {
        retweetCounter = tweet.retweetCount
        print(retweetCounter)
        retweetCounter += 1
        TwitterClient.sharedInstance.retweetCall(tweet.id!, success: {
            print("good job")
            self.detailsRetweetCountLabel.text = String(self.retweetCounter)
        }) { (error: NSError) in
            print("error: \(error.localizedDescription) oh no")
        }
    }
    
    @IBAction func onDetailsFavorite(sender: AnyObject) {
        favoriteCounter = tweet.favoritesCount
        print(favoriteCounter)
        favoriteCounter += 1
        TwitterClient.sharedInstance.favoriteCall(tweet.id!, success: {
            self.detailsFavoriteCountLabel.text = String(self.favoriteCounter)
            print("got that fave")
        }) { (error: NSError) in
            print("error: \(error.localizedDescription)")
        }

    }

    @IBAction func onReply(sender: AnyObject) {
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

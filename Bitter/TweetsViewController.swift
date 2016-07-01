//
//  TweetsViewController.swift
//  Bitter
//
//  Created by Jedidiah Akano on 6/28/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var tweets: [Tweet]!
    
    

    @IBOutlet weak var tweetTableView: TweetTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tweetTableView.insertSubview(refreshControl, atIndex: 0)
        tweetTableView.delegate = self
        tweetTableView.dataSource = self
        getTweetData()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func onNewTweet(sender: AnyObject) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        TwitterClient.sharedInstance.logOut()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            //print("oh no \(tweets)")
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetViewCell
        let tweet = tweets![indexPath.row]
        //print("\(tweet)")
        let text = tweet.text
        cell.tweet = tweet
        let name = tweet.user!.name
        let screenName = tweet.user!.screenName
        let profilePicture = tweet.user!.profileUrl
        cell.profileImageView.setImageWithURL(profilePicture!)
        let timeStampString = tweet.timeStamp
        let retweetCounter = tweet.retweetCount
        let favoriteCount = tweet.favoritesCount
        //print("\(tweet.timeStamp)")
        let index2 = timeStampString!.startIndex.advancedBy(2)
        let index1 = timeStampString!.startIndex.advancedBy(4)
        let index3 = timeStampString!.startIndex.advancedBy(3)
        if Int((timeStampString!.substringToIndex(index2))) < 10 {
            cell.timeStampLabel.text = timeStampString?.substringToIndex(index3)
        } else {
            cell.timeStampLabel.text = timeStampString?.substringToIndex(index1)
            
        }
        cell.favoriteLabel.text = String(favoriteCount)
        cell.handleLabel.text = "@\(screenName)"
        cell.tweetLabel.text = text
        cell.nameLabel.text = name
        cell.retweetCounterLabel.text = String(retweetCounter)
        
    
        
            return cell
    }
    
    func getTweetData() {
        TwitterClient.sharedInstance.homeTimline({ (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetTableView.reloadData()
            //print(tweets)
        }) { (error: NSError) in
                print("error: \(error.localizedDescription)")
        }        
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        getTweetData()
        self.tweetTableView.reloadData()
        refreshControl.endRefreshing()
    }

    @IBAction func onProfileButtonTap(sender: AnyObject) {
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as? UITableViewCell
        let indexPath = tweetTableView.indexPathForCell(cell!)
        let tweet = tweets![indexPath!.row]
        print("prepare for segue")
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.tweet = tweet
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

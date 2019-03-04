//
//  TweetCell.swift
//  Twitter
//
//  Created by Alexander Hall on 2/24/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {


    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Tweet: UILabel!
    
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var RetweetButton: UIButton!
    
    @IBAction func FavoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorited(true)
            }, failure: { (error) in
                print("favorite did not succeed: \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorited(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func ReTweet(_ sender: Any) {
        
        TwitterAPICaller.client?.ReTweet(tweetID: tweetID, success: {
            self.setReTweeted(true)
        }, failure: { (error) in
            print("Unable to Retweet: \(error)")
        })
    }
    
    var favorited:Bool = false
    var tweetID:Int = -1
//    var reTweeted:Bool = false
    
    func setFavorited(_ isFavorited: Bool){
        favorited = isFavorited
        if(favorited){
        FavoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
            
        }else{
            FavoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
            
        }
    }
    func setReTweeted(_ isRetweeted: Bool){
        if(isRetweeted){
            RetweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            RetweetButton.isEnabled = false
        }else{
            RetweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            RetweetButton.isEnabled = true
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Alexander Hall on 2/24/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func loadTweets(){
        numberOfTweets=20
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("could not load tweets")
        })
        
    }
    
    func loadMoreTweets(){
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets += numberOfTweets
        let myParams = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("could not load tweets")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.Name.text = user["name"] as! String
        cell.Tweet.text = tweetArray[indexPath.row]["text"] as! String
        
        let imageURL = URL(string:(user["profile_image_url_https"] as! String))
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data{
            cell.ProfileImageView.image = UIImage(data: imageData)
        }
        return cell
    }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

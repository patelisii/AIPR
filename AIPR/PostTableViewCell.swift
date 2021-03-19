//
//  PostTableViewCell.swift
//  AIPR
//
//  Created by Patrick Elisii on 2/28/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

   
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var proPicImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

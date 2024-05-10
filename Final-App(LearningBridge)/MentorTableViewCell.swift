//
//  MentorTableViewCell.swift
//  mentorScreen
//
//  Created by Sahil Aggarwal on 07/05/24.
//

import UIKit
// UITableViewCell subclass for displaying mentor session details in a table view
class MentorTableViewCell: UITableViewCell {
    @IBOutlet weak var sessionLabel: UILabel! // Label to display session details
    @IBOutlet weak var DateLabel: UILabel! // Label to display date of the session
    @IBOutlet weak var sessionImageView: UIImageView! // ImageView to display an image related to the session
    @IBOutlet weak var timeLabel: UILabel! // Label to display time of the session

}

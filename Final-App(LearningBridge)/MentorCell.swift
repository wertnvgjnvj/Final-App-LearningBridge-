import UIKit

class MentorCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!

    var isFollowing: Bool = false {
        didSet {
            let title = isFollowing ? "Following" : "Follow"
            followButton.setTitle(title, for: .normal)
            
            // Check background color and set text color accordingly
            if isFollowing {
                followButton.tintColor = UIColor.systemGray4
                if followButton.backgroundColor == UIColor.systemGray4 {
                    followButton.setTitleColor(UIColor.systemBlue, for: .normal)
                } else {
                    followButton.setTitleColor(UIColor.systemBlue, for: .normal)
                }
            } else {
                followButton.tintColor = UIColor.systemBlue
                followButton.setTitleColor(UIColor.white, for: .normal)
            }
            
            // Reset button appearance when it changes to "Follow"
            if !isFollowing {
                followButton.layer.borderWidth = 0
                followButton.layer.cornerRadius = 0
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        // Center text in labels
        nameLabel.textAlignment = .center
        designationLabel.textAlignment = .center

        // Center button text
        followButton.titleLabel?.textAlignment = .center

        // Set up profile image
//        profileImageView.contentMode = .scaleToFill
        profileImageView.layer.cornerRadius = 10
        profileImageView.clipsToBounds = true
        // Here you can assign a default image if needed
        profileImageView.image = UIImage(named: "default_profile_image")
    }

    @IBAction func followButtonTapped(_ sender: UIButton) {
        isFollowing.toggle()
        // Handle follow action here, e.g., update backend, UI, etc.
    }
}

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel! // Label to display the title of the item
    @IBOutlet weak var timeLabel: UILabel! // Label to display the time information of the item
    @IBOutlet weak var descriptionLabel: UILabel! // Label to display the description of the item
}

//class ImageDetailViewController: UIViewController {
//    @IBOutlet weak var imageView: UIImageView!
//    var image: UIImage?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imageView.image = image
//    }
//}

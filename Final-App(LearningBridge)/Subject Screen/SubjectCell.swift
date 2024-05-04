import UIKit

class SubjectCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.center = contentView.center
    }
    func applyCustomStyle(for subject: String) {
        // Set up the layer properties
        layer.cornerRadius = 12
      
        layer.masksToBounds = false
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        // Set up the title label properties
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20) // Bold and font size 20

        // Customize background image view appearance with gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds // Adjusted to cover the entire cell
        
        // Set gradient colors based on subject
        switch subject {
        case "English":
            gradientLayer.colors = [
                UIColor(hex: "#00a6fb").cgColor,
                UIColor(hex: "#003554").cgColor
            ]
        case "Science":
            gradientLayer.colors = [
                UIColor(hex: "#457b9d").cgColor,
                UIColor(hex: "#1d3557").cgColor
            ]
        case "History":
            gradientLayer.colors = [
                UIColor(hex: "#941b0c").cgColor,
                UIColor(hex: "#ff4800").cgColor
            ]
        case "Mathematics":
            gradientLayer.colors = [
                UIColor(hex: "#ffb600").cgColor,
                UIColor(hex: "#042a2b").cgColor
            ]
        case "Art":
            gradientLayer.colors = [
                UIColor(hex: "#a06cd5").cgColor,
                UIColor(hex: "#6247aa").cgColor
            ]
        case "Music":
            gradientLayer.colors = [
                UIColor(hex: "#e01e37").cgColor,
                UIColor(hex: "#6e1423").cgColor
            ]
        case "Physics":
            gradientLayer.colors = [
                UIColor(hex: "#ff7aa2").cgColor,
                UIColor(hex: "#602437").cgColor
            ]
        case "Chemistry":
            gradientLayer.colors = [
                UIColor(hex: "#aad576").cgColor,
                UIColor(hex: "#143601").cgColor
            ]
        case "Geography":
            gradientLayer.colors = [
                UIColor(hex: "#0D41E1").cgColor,
                UIColor(hex: "#0A85ED").cgColor
            ]
        case "Economics":
            gradientLayer.colors = [
                UIColor(hex: "#6fffe9").cgColor,
                UIColor(hex: "#0b132b").cgColor
            ]
        default:
            gradientLayer.colors = [
                UIColor.darkGray.cgColor,
                UIColor.black.cgColor
            ]
        }

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        backgroundImageView.layer.sublayers?.removeAll() // Remove existing sublayers
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)

        // Center the title label
        titleLabel.sizeToFit() // Adjust the label's size to its content
        titleLabel.center = CGPoint(x: bounds.midX, y: bounds.midY) // Center the label within the cell
    }

}
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

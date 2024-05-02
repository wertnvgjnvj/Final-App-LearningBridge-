import UIKit

class ChooseCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var chooseClassLabel: UILabel! // Outlet for the Choose Your Class label
    
    // Data
    let classes = ["Class 1", "Class 2", "Class 3", "Class 4", "Class 5", "Class 6", "Class 7", "Class 8", "Class 9", "Class 10", "Non Med", "Med"]
    let symbols = ["book", "book.fill", "square.and.pencil", "graduationcap", "building.columns", "waveform.path.ecg", "star", "star.fill", "bolt", "cloud.sun.rain", "heart", "heart.fill"]
    
    // Variable to store selected class
    var selectedClass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Set Choose Your Class label text
        chooseClassLabel.text = "Choose Your Class"
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCell", for: indexPath) as! ClassCell
        cell.titleLabel.text = classes[indexPath.item]
        let symbolName = symbols[indexPath.item % symbols.count] // To avoid index out of range, we use modulo
        print("Symbol Name: \(symbolName)") // Print symbol name for debugging
        cell.imageFetched.image = UIImage(systemName: symbolName)
        return cell
    }

    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedClass = classes[indexPath.item]
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width
        let numberOfColumns: CGFloat = 3 // Two columns
        let cellWidth = (totalWidth - (numberOfColumns - 15) * 10) / numberOfColumns // Adjust spacing between cells (10) as needed
        let cellHeight: CGFloat = 80 // Adjust height as needed
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Adjust spacing as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12 // Adjust spacing between cells horizontally
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12 // Adjust spacing between cells vertically
    }
    
    // Action method for continue button
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let selectedClass = selectedClass else {
            // Display an alert to prompt the user to select a class
            let alert = UIAlertController(title: "Selection Required", message: "Please select a class.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // Navigate to next screen or perform further actions
        print("Selected Class: \(selectedClass)")
    }
}


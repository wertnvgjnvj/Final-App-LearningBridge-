import UIKit

// The ChooseCollectionViewController class manages a collection view that allows users to choose a class.

class ChooseCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets
    
    // Collection view to display classes
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Label to indicate choosing a class
    @IBOutlet weak var chooseClassLabel: UILabel!
    
    // MARK: - Properties
    
    // Array containing the names of classes
    let classes = ["Class 1", "Class 2", "Class 3", "Class 4", "Class 5", "Class 6", "Class 7", "Class 8", "Class 9", "Class 10", "Non Med", "Med"]
    
    // Array containing the system symbols for each class
    let symbols = ["book", "book.fill", "square.and.pencil", "graduationcap", "building.columns", "waveform.path.ecg", "star", "star.fill", "bolt", "cloud.sun.rain", "heart", "heart.fill"]
    
    // Selected class
    var selectedClass: String?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set data source and delegate for the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Set text for the chooseClassLabel
        chooseClassLabel.text = "Choose Your Class"
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCell", for: indexPath) as! ClassCell
        cell.titleLabel.text = classes[indexPath.item]
        let symbolName = symbols[indexPath.item % symbols.count]
        cell.imageFetched.image = UIImage(systemName: symbolName)
        return cell
    }

    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedClass = classes[indexPath.item]
    }

    // MARK: - Actions
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let selectedClass = selectedClass else {
            let alert = UIAlertController(title: "Selection Required", message: "Please select a class.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        print("Selected Class: \(selectedClass)")
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the size of each cell based on the available width and desired spacing
        let totalWidth = collectionView.bounds.width
        let minimumSpacing: CGFloat = 10
        let inset: CGFloat = 10
        let availableWidth = totalWidth - (inset * 2) - (minimumSpacing * 2) // considering minimumSpacing on both sides of each cell
        let numberOfColumns = max(1, Int(availableWidth / (150 + minimumSpacing))) // assuming each cell width as 150, adjust as needed
        let cellWidth = (availableWidth - CGFloat(numberOfColumns - 1) * minimumSpacing) / CGFloat(numberOfColumns)
        let cellHeight: CGFloat = 80
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Set the inset for the section to provide spacing around the collection view cells
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Set the minimum interitem spacing between cells
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Set the minimum line spacing between cells
        return 10
    }
}

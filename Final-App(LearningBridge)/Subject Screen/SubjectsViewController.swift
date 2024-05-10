import UIKit
// This class manages the subjects view, displaying a collection of subjects and allowing the user to filter them using a search bar.
class SubjectsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
  
    // Outlet to display the selected class label in the navigation bar.
    @IBOutlet weak var labelShowed: UINavigationItem!
    // Outlet for the collection view displaying subjects.
    @IBOutlet weak var collectionView: UICollectionView!
    // Outlet for the search bar to filter subjects.
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Selected class by the user.
    var selectedClass: String?
    // Array containing all subjects.
    var subjects = ["English", "Science", "History", "Mathematics", "Art", "Music","Geography", "Economics", "Physics", "Chemistry"]
    // Array containing subjects filtered based on search.
    var filteredSubjects: [String] = [] // Filtered subjects based on search
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button in the navigation bar.
        navigationItem.hidesBackButton = true
        // Configure collection view data source and delegate.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Set up search bar delegate.
        searchBar.delegate = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchBarEmpty() {
            return subjects.count
        } else {
            return filteredSubjects.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubjectCell", for: indexPath) as! SubjectCell
        
        let subject: String
        if isSearchBarEmpty() {
            subject = subjects[indexPath.item]
        } else {
            subject = filteredSubjects[indexPath.item]
        }
        
        cell.titleLabel.text = subject
        
        // Apply custom styling to cell based on the subject.
        cell.applyCustomStyle(for: subject)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle selection by navigating to a PostViewController with the selected subject.
        let selectedSubject: String
        if isSearchBarEmpty() {
            selectedSubject = subjects[indexPath.item]
        } else {
            selectedSubject = filteredSubjects[indexPath.item]
        }

        // Create an instance of PostViewController.
        let postViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostViewController") as! PostViewController

        // Pass the selected subject to PostViewController.
        postViewController.navigationItem.title = selectedSubject
        postViewController.selectedSubject = selectedSubject
        // Push PostViewController onto the navigation stack.
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust cell size dynamically based on collection view width and desired spacing.
        let totalWidth = collectionView.bounds.width
        let numberOfColumns: CGFloat = 3
        let cellWidth = (totalWidth - (numberOfColumns - 15) * 10) / numberOfColumns // Adjust spacing between cells (10) as needed
        let cellHeight: CGFloat = 100 // Adjust height as needed
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust spacing between cells horizontally
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Adjust spacing as needed
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter subjects based on the search text and reload collection view data.
        filterSubjects(for: searchText)
        collectionView.reloadData()
    }
    
    // MARK: - Helper methods
    
    func isSearchBarEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func filterSubjects(for searchText: String) {
        // Filter subjects based on the search text ignoring case sensitivity.
        filteredSubjects = subjects.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    // MARK: - ChooseCollectionDelegate
    
    func didSelectClass(_ selectedClass: String) {
        // Update the displayed label with the selected class.
        labelShowed.title = selectedClass
    }
    
    // MARK: - Navigation
    
}

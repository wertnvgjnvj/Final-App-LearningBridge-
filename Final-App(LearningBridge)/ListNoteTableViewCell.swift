import UIKit

// UITableViewCell subclass for displaying a note in a list
class ListNoteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Static identifier for the cell reuse
    static let identifier = "ListNoteTableViewCell"
    
    // Outlets
    @IBOutlet weak private var titleLbl: UILabel! // Label to display the title of the note
    @IBOutlet weak private var descriptionLbl: UILabel! // Label to display the description of the note
    
    // MARK: - Methods
    
    // Configure the cell with a given note
    func setup(note: Note) {
        titleLbl.text = note.title // Set the title of the note
        descriptionLbl.text = note.desc // Set the description of the note
    }
}

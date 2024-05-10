import UIKit

// UIViewController subclass for editing a note
class EditNoteViewController: UIViewController {
    
    // MARK: - Properties
    
    // Static identifier for the view controller
    static let identifier = "EditNoteViewController"
    
    // Note instance to be edited
    var note: Note!
    
    // Delegate to communicate with the list of notes
    weak var delegate: ListNotesDelegate?
    
    // Outlet
    @IBOutlet weak private var textView: UITextView! // Text view to edit the note content
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note?.text // Set the text view content to the note's text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder() // Make the text view become the first responder when the view appears
    }
    
    // Dismiss the keyboard when touches are detected outside the text view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Methods
    
    // Update the note in the database and refresh the list of notes
    private func updateNote() {
        // TODO: Update the note in the database
        print("Updating note")
        
        note.lastUpdated = Date() // Update the last updated timestamp
        delegate?.refreshNotes() // Notify the delegate to refresh the list of notes
    }
    
    // Delete the note from the database and notify the delegate
    private func deleteNote() {
        // TODO: Delete the note from the database
        print("Deleting note")
        
        delegate?.deleteNote(with: note.id) // Notify the delegate to delete the note
    }
}

// MARK: - UITextView Delegate

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text // Update the note's text with the text view content
        if note?.title.isEmpty ?? true { // If the note's title is empty
            deleteNote() // Delete the note
        } else {
            updateNote() // Otherwise, update the note
        }
    }
}

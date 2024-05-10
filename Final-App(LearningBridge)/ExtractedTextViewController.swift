import UIKit

class ExtractedTextViewController: UIViewController {
    var recordedText: String?
    var startTime: Date?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var recordedTextView: UITextView!
    @IBOutlet weak var startEvaluating: UIButton!
    
    var extractedText: String = "Hello Hello"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        // Background color
        
        // Text view styling
        textView.text = extractedText
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
     
        
        // Recorded text view styling
        recordedTextView.text = recordedText
        recordedTextView.textColor = UIColor.black
        recordedTextView.backgroundColor = UIColor.white
      
    
        // Start evaluating button styling
        startEvaluating.setTitleColor(UIColor.white, for: .normal)

 
    }
    
    @IBAction func startEvaluatingTapped(_ sender: UIButton) {
        guard let recordedText = recordedText else {
            // Handle the case where recorded text is nil
            return
        }
        
        let endTime = Date()
        let timeSpent = endTime.timeIntervalSince(startTime ?? Date())
        
        // Perform comparison logic between recorded text and extracted text
        let marksScore = calculateMarksScore(recordedText: recordedText, extractedText: extractedText)
        
        // Show alert with results generated
        let alert = UIAlertController(title: "Results Generated", message: "Marks Score: \(marksScore)\nTime Spent: \(stringFromTimeInterval(timeInterval: timeSpent))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Proceed to EvaluationResultsViewController
            self.presentEvaluationResultsViewController(recordedText: recordedText, marksScore: marksScore, timeSpent: timeSpent)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func calculateMarksScore(recordedText: String, extractedText: String) -> Int {
        let recordedWords = recordedText.components(separatedBy: .whitespacesAndNewlines)
        let extractedWords = extractedText.components(separatedBy: .whitespacesAndNewlines)
        
        // Calculate the total number of words in the recorded text
        let totalWordsCount = recordedWords.count
        
        // Calculate the number of matching words between recorded text and extracted text
        var matchingWordsCount = 0
        for word in extractedWords {
            if recordedWords.contains(word) {
                matchingWordsCount += 1
            }
        }
        
        // Calculate the marks score based on the matching words count
        let marksScore: Int
        if totalWordsCount > 0 {
            let percentage = Double(matchingWordsCount) / Double(totalWordsCount)
            marksScore = Int(percentage * 100)
        } else {
            marksScore = 0
        }
        
        return marksScore
    }
    
    func stringFromTimeInterval(timeInterval: TimeInterval) -> String {
        let timeInterval = Int(timeInterval)
        let seconds = timeInterval % 60
        let minutes = (timeInterval / 60) % 60
        let hours = timeInterval / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func presentEvaluationResultsViewController(recordedText: String, marksScore: Int, timeSpent: TimeInterval) {
        // Pass the necessary data to EvaluationResultsViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let navigationVC = storyboard.instantiateViewController(withIdentifier: "YourNavigationControllerIdentifier") as? UINavigationController,
           let evaluationResultsVC = navigationVC.topViewController as? EvaluationResultsViewController {
            
            evaluationResultsVC.recordedText = recordedText
            evaluationResultsVC.marksScore = marksScore
            evaluationResultsVC.timeSpent = timeSpent
            
            // Present the navigation controller
            present(navigationVC, animated: true, completion: nil)
        }
    }
}

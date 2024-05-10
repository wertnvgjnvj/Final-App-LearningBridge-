import UIKit

class EvaluationResultsViewController: UIViewController {
    // Outlets for displaying marks score, time spent, and rank
    @IBOutlet weak var marksScoreLabel: UILabel!
    @IBOutlet weak var printMarks: UILabel!
    @IBOutlet weak var timeSpentLabel: UILabel!
    @IBOutlet weak var printTime: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var printRank: UILabel!
    @IBOutlet weak var marksSlider: UISlider!
    @IBOutlet weak var timeSpentSlider: UISlider!
    @IBOutlet weak var rankSlider: UISlider!
    @IBOutlet weak var tasksTableView: UITableView! // Outlet for Task TableView
    
    // Properties to store data passed from ExtractedTextViewController
    var recordedText: String?
    var extractedText: String?
    var marksScore: Int?
    var timeSpent: TimeInterval?
    
    // Data for tasks
    var tasks: [[String: Any]] = [
        ["title": "Braille English", "completion": 47, "time": TimeInterval(0)],
        ["title": "Braille Hindi", "completion": 95, "time": TimeInterval(0)]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update UI with the passed data
        marksScoreLabel.text = "Marks Score: "
        printMarks.text = "\(marksScore ?? 0)"
        if let timeSpent = timeSpent {
            let timeSpentString = stringFromTimeInterval(timeInterval: timeSpent)
            timeSpentLabel.text = "Time Spent: \n"
            printTime.text = "\(timeSpentString)"
        } else {
            timeSpentLabel.text = "Time Spent: N/A"
        }
        
        // Configure sliders
        marksSlider.minimumValue = 0
        marksSlider.maximumValue = 100
        marksSlider.value = Float(marksScore ?? 0)
        
        timeSpentSlider.minimumValue = 0
        timeSpentSlider.maximumValue = 3600 // 1 hour
        timeSpentSlider.value = Float(timeSpent ?? 0)
        
        rankSlider.minimumValue = 0
        rankSlider.maximumValue = 100
        rankSlider.value = Float(marksScore ?? 0)
        
        // Configure TableView
        tasksTableView.dataSource = self
        tasksTableView.reloadData()
        
        // Add header view for Tasks section
        let tasksHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tasksTableView.frame.width, height: 50))
        let tasksHeaderLabel = UILabel(frame: CGRect(x: 10, y: 0, width: tasksHeaderView.frame.width - 20, height: 50))
        tasksHeaderLabel.text = "Tasks"
        tasksHeaderLabel.font = UIFont.boldSystemFont(ofSize: 20)
        tasksHeaderView.addSubview(tasksHeaderLabel)
        tasksTableView.tableHeaderView = tasksHeaderView
    }
    
    // Function to convert time interval to string
    func stringFromTimeInterval(timeInterval: TimeInterval) -> String {
        let timeInterval = Int(timeInterval)
        let seconds = timeInterval % 60
        let minutes = (timeInterval / 60) % 60
        let hours = timeInterval / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // Action method for marks slider value change
    @IBAction func marksSliderValueChanged(_ sender: UISlider) {
        marksScoreLabel.text = "Marks Score: \(Int(sender.value))"
    }
    
    // Action method for time spent slider value change
    @IBAction func timeSpentSliderValueChanged(_ sender: UISlider) {
        let timeSpentString = stringFromTimeInterval(timeInterval: TimeInterval(sender.value))
        timeSpentLabel.text = "Time Spent: \(timeSpentString)"
    }
    
    // Action method for rank slider value change
    @IBAction func rankSliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        updateRankLabel(value: value)
    }
    
    // Update the rank label based on the slider value
    func updateRankLabel(value: Int) {
        rankLabel.text = "Rank: "
        printRank.text = "\(value)"
    }
}

extension EvaluationResultsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Each task has only one row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        let task = tasks[indexPath.section]
        cell.textLabel?.text = task["title"] as? String
        
        let completion = task["completion"] as? Int ?? 0
        cell.detailTextLabel?.text = "Completion: \(completion)%"
        
        // You can also display the time spent here if needed
        
        return cell
    }
}

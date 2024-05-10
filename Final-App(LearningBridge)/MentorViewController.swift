import UIKit
// The MentorsViewController class manages the user interface for displaying mentors and filtering them by subject.
class MentorsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {

    // Collection view to display mentor cells
        @IBOutlet weak var collectionView: UICollectionView!
        
        // Label to display the selected subject
        @IBOutlet weak var subjectLabel: UILabel!
        
        // Button to toggle the visibility of the subject dropdown
        @IBOutlet weak var dropdownButton: UIButton!
        
        // View containing the dropdown table view
        @IBOutlet weak var myDropDownView: UIView!
        
        // Table view to display subjects for filtering
        @IBOutlet weak var tableView: UITableView!

    
    // Search bar for searching mentors
    @IBOutlet weak var searchMentor: UISearchBar!
    var mentors: [Mentor] = []
    let allMentors = [
        Mentor(name: "John Doe", designation: "English", followers: "10K", interaction: "Good", experience: "5 years", likes: "5K", profile: "profile-1", description: "Passionate English educator dedicated to empowering students through language, fostering growth beyond the classroom."),
        Mentor(name: "Jane Smith", designation: "English", followers: "8K", interaction: "Nice", experience: "8 years", likes: "7K", profile: "profile-2", description: "With 8 years of experience, I create an engaging learning environment to make English learning fun and effective."),
        Mentor(name: "Robert", designation: "English", followers: "12K", interaction: "Best", experience: "10 years", likes:"6K", profile: "profile-3", description: "Transforming English learning with 10 years of expertise, fostering excellence and confidence in every student."),
        Mentor(name: "Marry", designation: "Mathematics", followers: "15K", interaction: "Good", experience: "6 years", likes: "5K", profile: "profile-4", description: "Innovative Math educator with 6 years' experience, simplifying complex concepts for enjoyable learning."),
        Mentor(name: "Ada Lovelace", designation: "Mathematics", followers: "18K", interaction: "Nice", experience: "9 years", likes: "12K", profile: "profile-7", description: "Dedicated Mathematics mentor for 9 years, nurturing mathematical talent and fostering analytical thinking."),
        Mentor(name: "Marie Curie", designation: "Physics", followers: "20K", interaction: "Good", experience: "11 years", likes: "15K", profile: "profile-1", description: "Inspiring Physics educator with 11 years of experience, igniting curiosity and passion for scientific inquiry."),
        Mentor(name: "Max Planck", designation: "Physics", followers: "25K", interaction: "Good", experience: "7 years", likes: "8K", profile: "profile-3", description: "Engaging Physics mentor for 7 years, making complex concepts accessible and fostering a love for discovery."),
        Mentor(name: "Werner", designation: "Physics", followers: "22K", interaction: "Best", experience: "10 years", likes: "9K", profile: "profile-8", description: "Dedicated Physics educator with 10 years of experience, nurturing scientific curiosity and critical thinking."),
        Mentor(name: "Marie Curie", designation: "Chemistry", followers: "7K", interaction: "", experience: "12 years", likes: "18K", profile: "profile-9", description: "Pioneering Chemistry mentor with 12 years' experience, inspiring a new generation of scientific innovators."),
        Mentor(name: "Robert Hooke", designation: "Chemistry", followers: "16K", interaction: "Good", experience: "8 years", likes: "9K", profile: "profile-10", description: "Passionate Chemistry educator for 8 years, fostering a deep understanding and appreciation for the molecular world."),
        Mentor(name: "Antoine Lavoisier", designation: "Chemistry", followers: "19K", interaction: "Nice", experience: "11 years", likes: "13K", profile: "profile-11", description: "Distinguished Chemistry mentor with 11 years' experience, shaping future scientists through hands-on exploration."),
        Mentor(name: "Marie Curie", designation: "Science", followers: "2K", interaction: "Good", experience: "13 years", likes: "2K", profile: "profile-12", description: "Visionary Science educator for 13 years, instilling a passion for discovery and innovation in every student."),
        Mentor(name: "Max Planck", designation: "Science", followers: "23K", interaction: "Good", experience: "9 years", likes: "14K", profile: "profile-13", description: "Dynamic Science mentor with 9 years' experience, fostering a love for scientific exploration and inquiry."),
        Mentor(name: "Alexander ", designation: "History", followers: "27K", interaction: "Nice", experience: "14 years", likes: "3K", profile: "profile-14", description: "Passionate History educator for 14 years, bringing the past to life and inspiring critical thinking."),
        Mentor(name: "Cleopatra", designation: "History", followers: "26K", interaction: "Best", experience: "15 years", likes: "23K", profile: "profile-15", description: "Experienced History mentor for 15 years, unlocking the mysteries of the past and shaping future perspectives."),
        Mentor(name: "Winston", designation: "History", followers: "26K", interaction: "Good", experience: "10 years", likes: "7K", profile: "profile-16", description: "Engaging History educator for 10 years, fostering a deep understanding of the past and its relevance today."),
        Mentor(name: "Leonardo ", designation: "Art", followers: "28K", interaction: "Nice", experience: "16 years", likes: "2K", profile: "profile-17", description: "Creative Art mentor for 16 years, nurturing artistic expression and fostering a love for visual storytelling."),
        Mentor(name: "Vincent ", designation: "Art", followers: "29K", interaction: "Good", experience: "17 years", likes: "1K", profile: "profile-18", description: "Inspiring Art educator with 17 years' experience, cultivating creativity and imagination in every brushstroke."),
        Mentor(name: "Pablo Picasso", designation: "Art", followers: "31K", interaction: "Good", experience: "11 years", likes: "17K", profile: "profile-19", description: "Innovative Art mentor for 11 years, pushing boundaries and redefining artistic expression."),
        Mentor(name: "Johann ", designation: "Music", followers: "38K", interaction: "Best", experience: "18 years", likes: "26k", profile: "profile-20", description: "Passionate Music educator for 18 years, nurturing musical talent and inspiring a lifelong love for melody."),
        Mentor(name: "Frederic Chopin", designation: "Music", followers: "33K", interaction: "Good", experience: "19 years", likes: "27K", profile: "profile-21", description: "Masterful Music mentor with 19 years' experience, shaping the next generation of musical virtuosos."),
        Mentor(name: "Johannes Brahms", designation: "Music", followers: "3K", interaction: "Good", experience: "12 years", likes: "3K", profile: "profile-22", description: "Dedicated Music educator for 12 years, fostering musical excellence and creativity in every note."),
        Mentor(name: "Alexander von", designation: "Geography", followers: "9K", interaction: "Nice", experience: "20 years", likes: "4K", profile: "profile-23", description: "Inspiring Geography mentor for 20 years, exploring the world's wonders and fostering global perspectives."),
        Mentor(name: "Gerardus ", designation: "Geography", followers: "7K", interaction: "", experience: "21 years", likes: "29K", profile: "profile-24", description: "Passionate Geography educator for 21 years, instilling a love for exploration and understanding of our planet."),
        Mentor(name: "Friedrich Hayek", designation: "Economics", followers: "8K", interaction: "good", experience: "13 years", likes: "3K", profile: "profile-25", description: "Insightful Economics mentor for 13 years, exploring economic theories and their impact on society."),
        Mentor(name: "Paul Samuelson", designation: "Economics", followers: "36K", interaction: "excellent", experience: "22 years", likes: "30K", profile: "profile-26", description: "Economics expert with 22 years' experience, guiding students to understand the complexities of global markets."),
        Mentor(name: "Amartya Sen", designation: "Economics", followers: "8K", interaction: "outstanding", experience: "23 years", likes: "31K", profile: "profile-27", description: "Distinguished Economics mentor for 23 years, championing social justice and economic empowerment."),
        Mentor(name: "John", designation: "Economics", followers: "2K", interaction: "good", experience: "14 years", likes: "7K", profile: "profile-28", description: "Experienced Economics educator for 14 years, exploring economic principles and their real-world applications.")
    ]

    let subjects = [
        "English",
        "Science",
        "History",
        "Mathematics",
        "Art",
        "Music",
        "Physics",
        "Chemistry",
        "Geography",
        "Economics"
    ]
    // Array to hold filtered mentors based on selected subject
    var filteredMentors: [Mentor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up data sources and delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        // Hide the table view initially
        tableView.isHidden = true

        // Register SubjectCell for SubjectCell identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SubjectCell")

        // Apply shadow to the tableView
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.2
        tableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tableView.layer.masksToBounds = false // This is important to clip the shadow to the view's bounds

        // Initially, set mentors to all mentors
        mentors = allMentors

        // Initialize filteredMentors with mentors who have "English" as their designation
        filteredMentors = allMentors.filter { $0.designation == "English" }

        // Reload the collection view to display the filtered mentors
        collectionView.reloadData()
    }

    @IBAction func isTappedDropdownButton(_ sender: Any) {
        // Toggle the visibility of the table view
        tableView.isHidden = !tableView.isHidden
    }

    // MARK: - UICollectionViewDataSource
    // Function to determine the number of items in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMentors.count
    }

    // Function to configure and return a cell for the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue a reusable cell of type MentorCell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MentorCell", for: indexPath) as? MentorCell else {
            fatalError("Unable to dequeue MentorCell")
        }

        let mentor = filteredMentors[indexPath.item] // Retrieve mentor data for the current index
        // Set mentor data to cell components
        cell.nameLabel.text = mentor.name
        cell.designationLabel.text = mentor.designation

        // Set custom profile image for each cell
        cell.profileImageView.image = UIImage(named: mentor.profile)

        // Customize follow button appearance based on follow state
        cell.isFollowing = false // Or fetch actual follow state from data

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 160, height: 200)
//    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // Get the selected mentor
            let selectedMentor = filteredMentors[indexPath.item]
            
            // Perform segue to show mentor detail view controller
            performSegue(withIdentifier: "ShowMentorDetail", sender: selectedMentor)
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath)
        cell.textLabel?.text = subjects[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14) // Set smaller text size

        // Set default background color
        cell.backgroundColor = UIColor.clear

        // Add hover effect
        let bgView = UIView()
        bgView.backgroundColor = UIColor.systemBlue.withAlphaComponent(1.0) // Set system blue with some transparency
        cell.selectedBackgroundView = bgView

        // Set text color to white on hover
        cell.textLabel?.highlightedTextColor = UIColor.white

        return cell
    }


    // MARK: - UITableViewDelegate

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected subject from the subjects array using the indexPath.row
        let selectedSubject = subjects[indexPath.row]

        // Update the subjectLabel with the selected subject
        subjectLabel.text = selectedSubject

        // Filter mentors based on the selected subject
        filteredMentors = allMentors.filter { $0.designation == selectedSubject }

        // Reload collection view to display filtered mentors
        collectionView.reloadData()

        // Hide the table view
        tableView.isHidden = true
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//           let availableWidth = view.frame.width - paddingSpace
//           let widthPerItem = availableWidth / itemsPerRow
//           return CGSize(width: widthPerItem, height: 200)
//       }
    
    // Function to define the minimum inter-item spacing for each line in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 0.0
    }
    
    // Function to define the size for items in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: 200)
        }
    

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return sectionInsets
       }

//       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//           return sectionInsets.left
//       }

       // MARK: - Properties
    // Number of items per row in the collection view
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    

       
}

extension MentorsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowMentorDetail",
               let mentorDetailVC = segue.destination as? MentorDetailViewController,
               let selectedMentor = sender as? Mentor {
                mentorDetailVC.mentor = selectedMentor
            }
        }
    
    
}

// MARK: - Mentor Struct

// Structure to represent a mentor with various attributes
struct Mentor {
    let name: String
    let designation: String
    let followers: String
    let interaction: String
    let experience: String
    let likes: String
    let profile: String
    let description: String
}



import UIKit

class MentorDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Structure to represent a session with its details
    struct Session {
        let sessionTopic: String
        let sessionDate: String
        let sessionCover: String
        let sessionTime: String
    }

    // Outlets to connect UI elements from the storyboard
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var interaction: UILabel!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var likes: UILabel!
  
    @IBOutlet weak var MentorLabel: UITextView!
    @IBOutlet weak var table: UITableView!
    // Dictionary to hold session data for each mentor
    let sessionData: [String: [Session]] = [
        "John Doe": [
            Session(sessionTopic: "Grammar Basics", sessionDate: "2024-05-10", sessionCover: "session-1", sessionTime: "10:00 AM"),
            Session(sessionTopic: "Communication Tips", sessionDate: "2024-05-15", sessionCover: "session-2", sessionTime: "2:00 PM"),
            Session(sessionTopic: "Literary Analysis", sessionDate: "2024-05-20", sessionCover: "session-3", sessionTime: "3:30 PM"),
            Session(sessionTopic: "Poetry Writing", sessionDate: "2024-05-25", sessionCover: "session-4", sessionTime: "11:00 AM"),
            Session(sessionTopic: "Classic Literature", sessionDate: "2024-05-30", sessionCover: "session-5", sessionTime: "4:00 PM")
        ],
        "Jane Smith": [
            Session(sessionTopic: "Grammar Techniques", sessionDate: "2024-05-11", sessionCover: "grammar.jpg", sessionTime: "9:00 AM"),
            Session(sessionTopic: "Language Fluency", sessionDate: "2024-05-16", sessionCover: "communication.jpg", sessionTime: "1:00 PM"),
            Session(sessionTopic: "Literature Appreciation", sessionDate: "2024-05-21", sessionCover: "literature.jpg", sessionTime: "2:30 PM"),
            Session(sessionTopic: "Creative Writing", sessionDate: "2024-05-26", sessionCover: "poetry.jpg", sessionTime: "10:30 AM"),
            Session(sessionTopic: "Modern Fiction", sessionDate: "2024-05-31", sessionCover: "classics.jpg", sessionTime: "3:00 PM")
        ],
        "Robert": [
            Session(sessionTopic: "English Basics", sessionDate: "2024-05-12", sessionCover: "grammar.jpg", sessionTime: "11:00 AM"),
            Session(sessionTopic: "Writing Skills", sessionDate: "2024-05-17", sessionCover: "communication.jpg", sessionTime: "3:00 PM"),
            Session(sessionTopic: "Literary Masterpieces", sessionDate: "2024-05-22", sessionCover: "literature.jpg", sessionTime: "1:30 PM"),
            Session(sessionTopic: "Poetry Appreciation", sessionDate: "2024-05-27", sessionCover: "poetry.jpg", sessionTime: "9:30 AM"),
            Session(sessionTopic: "Shakespearean Drama", sessionDate: "2024-06-01", sessionCover: "classics.jpg", sessionTime: "2:30 PM")
        ],
        "Michael": [
                Session(sessionTopic: "Basic Arithmetic", sessionDate: "2024-05-14", sessionCover: "math.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Algebra Fundamentals", sessionDate: "2024-05-19", sessionCover: "algebra.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Geometry Essentials", sessionDate: "2024-05-24", sessionCover: "geometry.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Trigonometry Basics", sessionDate: "2024-05-29", sessionCover: "trigonometry.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Calculus Introduction", sessionDate: "2024-06-03", sessionCover: "calculus.jpg", sessionTime: "4:00 PM")
            ],
        "Ada Lovelace": [
                Session(sessionTopic: "Mathematical Concepts", sessionDate: "2024-05-15", sessionCover: "math.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Probability Basics", sessionDate: "2024-05-20", sessionCover: "probability.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Data Analysis Techniques", sessionDate: "2024-05-25", sessionCover: "data_analysis.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Linear Algebra Fundamentals", sessionDate: "2024-05-30", sessionCover: "linear_algebra.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Statistics Applications", sessionDate: "2024-06-04", sessionCover: "statistics.jpg", sessionTime: "3:00 PM")
        ],
            "Max Planck": [
                Session(sessionTopic: "Physics Fundamentals", sessionDate: "2024-05-17", sessionCover: "physics.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Electromagnetism Basics", sessionDate: "2024-05-22", sessionCover: "electromagnetism.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Thermodynamics Essentials", sessionDate: "2024-05-27", sessionCover: "thermodynamics.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Optics Principles", sessionDate: "2024-06-01", sessionCover: "optics.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Astrophysics Insights", sessionDate: "2024-06-06", sessionCover: "astrophysics.jpg", sessionTime: "4:00 PM")
            ],
            "Werner": [
                Session(sessionTopic: "Principles of Physics", sessionDate: "2024-05-18", sessionCover: "physics.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Relativity Theory", sessionDate: "2024-05-23", sessionCover: "relativity.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Quantum Field Theory", sessionDate: "2024-05-28", sessionCover: "quantum_field.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Cosmology Basics", sessionDate: "2024-06-02", sessionCover: "cosmology.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "String Theory", sessionDate: "2024-06-07", sessionCover: "string_theory.jpg", sessionTime: "3:00 PM")
            ],
            "Marie Curie": [
                Session(sessionTopic: "Chemical Elements", sessionDate: "2024-05-19", sessionCover: "chemistry.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Chemical Bonds", sessionDate: "2024-05-24", sessionCover: "chemical_bonds.jpg", sessionTime: "3:00 PM"),
                Session(sessionTopic: "Chemical Reactions", sessionDate: "2024-05-29", sessionCover: "chemical_reactions.jpg", sessionTime: "1:30 PM"),
                Session(sessionTopic: "Organic Chemistry", sessionDate: "2024-06-03", sessionCover: "organic_chemistry.jpg", sessionTime: "9:30 AM"),
                Session(sessionTopic: "Biochemistry Essentials", sessionDate: "2024-06-08", sessionCover: "biochemistry.jpg", sessionTime: "2:30 PM")
            ],
            "Robert Hooke": [
                Session(sessionTopic: "Molecular Structure", sessionDate: "2024-05-20", sessionCover: "molecular_structure.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Chemical Equilibria", sessionDate: "2024-05-25", sessionCover: "chemical_equilibria.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Thermodynamics in Chemistry", sessionDate: "2024-05-30", sessionCover: "thermodynamics_chemistry.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Chemical Kinetics", sessionDate: "2024-06-04", sessionCover: "chemical_kinetics.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Nanotechnology Applications", sessionDate: "2024-06-09", sessionCover: "nanotechnology.jpg", sessionTime: "4:00 PM")
            ],
            "Antoine Lavoisier": [
                Session(sessionTopic: "Chemical Stoichiometry", sessionDate: "2024-05-21", sessionCover: "stoichiometry.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Acids and Bases", sessionDate: "2024-05-26", sessionCover: "acids_bases.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Chemical Thermodynamics", sessionDate: "2024-05-31", sessionCover: "chemical_thermodynamics.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Electrochemistry Basics", sessionDate: "2024-06-05", sessionCover: "electrochemistry.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Chemical Engineering Principles", sessionDate: "2024-06-10", sessionCover: "chemical_engineering.jpg", sessionTime: "3:00 PM")
            ],
            "Marie Curie (S": [
                Session(sessionTopic: "Scientific Method", sessionDate: "2024-05-22", sessionCover: "scientific_method.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Science and Society", sessionDate: "2024-05-27", sessionCover: "science_society.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Research Methodology", sessionDate: "2024-06-01", sessionCover: "research_methodology.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Experimental Design", sessionDate: "2024-06-06", sessionCover: "experimental_design.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Scientific Ethics", sessionDate: "2024-06-11", sessionCover: "scientific_ethics.jpg", sessionTime: "4:00 PM")
            ],
            "Max Planck (Science)": [
                Session(sessionTopic: "Scientific Inquiry", sessionDate: "2024-05-23", sessionCover: "scientific_inquiry.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Scientific Communication", sessionDate: "2024-05-28", sessionCover: "scientific_communication.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Data Interpretation", sessionDate: "2024-06-02", sessionCover: "data_interpretation.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Hypothesis Testing", sessionDate: "2024-06-07", sessionCover: "hypothesis_testing.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Peer Review Process", sessionDate: "2024-06-12", sessionCover: "peer_review.jpg", sessionTime: "3:00 PM")
            ],
            "Alexander": [
                Session(sessionTopic: "Ancient Civilizations", sessionDate: "2024-05-24", sessionCover: "ancient_civilizations.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Renaissance Era", sessionDate: "2024-05-29", sessionCover: "renaissance_era.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "World War I", sessionDate: "2024-06-03", sessionCover: "world_war1.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Cold War Events", sessionDate: "2024-06-08", sessionCover: "cold_war.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Modern Political Movements", sessionDate: "2024-06-13", sessionCover: "modern_politics.jpg", sessionTime: "4:00 PM")
            ],
            "Cleopatra": [
                Session(sessionTopic: "Ancient Egypt", sessionDate: "2024-05-25", sessionCover: "ancient_egypt.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Roman Empire", sessionDate: "2024-05-30", sessionCover: "roman_empire.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Greek Civilization", sessionDate: "2024-06-04", sessionCover: "greek_civilization.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Medieval Europe", sessionDate: "2024-06-09", sessionCover: "medieval_europe.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Colonialism Era", sessionDate: "2024-06-14", sessionCover: "colonialism.jpg", sessionTime: "3:00 PM")
            ],
            "Winston": [
                Session(sessionTopic: "World War II", sessionDate: "2024-05-26", sessionCover: "world_war2.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Industrial Revolution", sessionDate: "2024-05-31", sessionCover: "industrial_revolution.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "French Revolution", sessionDate: "2024-06-05", sessionCover: "french_revolution.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "American Revolution", sessionDate: "2024-06-10", sessionCover: "american_revolution.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Civil Rights Movement", sessionDate: "2024-06-15", sessionCover: "civil_rights.jpg", sessionTime: "4:00 PM")
            ],
            "Leonardo": [
                Session(sessionTopic: "Renaissance Art", sessionDate: "2024-05-27", sessionCover: "renaissance_art.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Baroque Period", sessionDate: "2024-06-01", sessionCover: "baroque.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Impressionism", sessionDate: "2024-06-06", sessionCover: "impressionism.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Cubism Movement", sessionDate: "2024-06-11", sessionCover: "cubism.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Modern Art Trends", sessionDate: "2024-06-16", sessionCover: "modern_art.jpg", sessionTime: "3:00 PM")
            ],
        "Vincent": [
                Session(sessionTopic: "Painting Techniques", sessionDate: "2024-06-17", sessionCover: "painting_techniques.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Color Theory", sessionDate: "2024-06-22", sessionCover: "color_theory.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Portrait Drawing", sessionDate: "2024-06-27", sessionCover: "portrait_drawing.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Landscape Painting", sessionDate: "2024-07-02", sessionCover: "landscape_painting.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Abstract Art", sessionDate: "2024-07-07", sessionCover: "abstract_art.jpg", sessionTime: "4:00 PM")
            ],
            "Pablo Picasso": [
                Session(sessionTopic: "Cubism Movement", sessionDate: "2024-06-18", sessionCover: "cubism.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Surrealism Art", sessionDate: "2024-06-23", sessionCover: "surrealism.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Modern Art Trends", sessionDate: "2024-06-28", sessionCover: "modern_art.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Artistic Innovations", sessionDate: "2024-07-03", sessionCover: "artistic_innovations.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Artistic Philosophy", sessionDate: "2024-07-08", sessionCover: "art_philosophy.jpg", sessionTime: "3:00 PM")
            ],
            "Johann": [
                Session(sessionTopic: "Musical Theory", sessionDate: "2024-06-19", sessionCover: "musical_theory.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Composition Techniques", sessionDate: "2024-06-24", sessionCover: "composition_techniques.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Performance Skills", sessionDate: "2024-06-29", sessionCover: "performance_skills.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Music History", sessionDate: "2024-07-04", sessionCover: "music_history.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Musical Collaboration", sessionDate: "2024-07-09", sessionCover: "musical_collaboration.jpg", sessionTime: "4:00 PM")
            ],
            "Frederic Chopin": [
                Session(sessionTopic: "Piano Techniques", sessionDate: "2024-06-20", sessionCover: "piano_techniques.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Composition Masterclass", sessionDate: "2024-06-25", sessionCover: "composition_masterclass.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Interpretation Skills", sessionDate: "2024-06-30", sessionCover: "interpretation_skills.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Chopin's Works", sessionDate: "2024-07-05", sessionCover: "chopin_works.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Musical Expression", sessionDate: "2024-07-10", sessionCover: "musical_expression.jpg", sessionTime: "3:00 PM")
            ],
            "Johannes Brahms": [
                Session(sessionTopic: "Classical Music", sessionDate: "2024-06-21", sessionCover: "classical_music.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Symphony Composition", sessionDate: "2024-06-26", sessionCover: "symphony_composition.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Concerto Performance", sessionDate: "2024-07-01", sessionCover: "concerto_performance.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Music Analysis", sessionDate: "2024-07-06", sessionCover: "music_analysis.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Musical Interpretation", sessionDate: "2024-07-11", sessionCover: "musical_interpretation.jpg", sessionTime: "4:00 PM")
            ],
            "Alexander von": [
                Session(sessionTopic: "Physical Geography", sessionDate: "2024-06-22", sessionCover: "physical_geography.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Human Geography", sessionDate: "2024-06-27", sessionCover: "human_geography.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Environmental Studies", sessionDate: "2024-07-02", sessionCover: "environmental_studies.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Geopolitics", sessionDate: "2024-07-07", sessionCover: "geopolitics.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Geographical Mapping", sessionDate: "2024-07-12", sessionCover: "geographical_mapping.jpg", sessionTime: "4:00 PM")
            ],
            "Gerardus": [
                Session(sessionTopic: "Geological Studies", sessionDate: "2024-06-23", sessionCover: "geological_studies.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Climatology", sessionDate: "2024-06-28", sessionCover: "climatology.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Urban Geography", sessionDate: "2024-07-03", sessionCover: "urban_geography.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Geographical Research", sessionDate: "2024-07-08", sessionCover: "geographical_research.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Geographical Trends", sessionDate: "2024-07-13", sessionCover: "geographical_trends.jpg", sessionTime: "3:00 PM")
            ],
            "Friedrich Hayek": [
                Session(sessionTopic: "Economic Theory", sessionDate: "2024-06-24", sessionCover: "economic_theory.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Market Dynamics", sessionDate: "2024-06-29", sessionCover: "market_dynamics.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Global Economics", sessionDate: "2024-07-04", sessionCover: "global_economics.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Economic Policy", sessionDate: "2024-07-09", sessionCover: "economic_policy.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Economic Development", sessionDate: "2024-07-14", sessionCover: "economic_development.jpg", sessionTime: "4:00 PM")
            ],
            "Paul Samuelson": [
                Session(sessionTopic: "Microeconomics", sessionDate: "2024-06-25", sessionCover: "microeconomics.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Macroeconomics", sessionDate: "2024-06-30", sessionCover: "macroeconomics.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "International Economics", sessionDate: "2024-07-05", sessionCover: "international_economics.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Economic Analysis", sessionDate: "2024-07-10", sessionCover: "economic_analysis.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Economic Forecasting", sessionDate: "2024-07-15", sessionCover: "economic_forecasting.jpg", sessionTime: "3:00 PM")
            ],
            "Amartya Sen": [
                Session(sessionTopic: "Development Economics", sessionDate: "2024-06-26", sessionCover: "development_economics.jpg", sessionTime: "10:00 AM"),
                Session(sessionTopic: "Welfare Economics", sessionDate: "2024-07-01", sessionCover: "welfare_economics.jpg", sessionTime: "2:00 PM"),
                Session(sessionTopic: "Economic Justice", sessionDate: "2024-07-06", sessionCover: "economic_justice.jpg", sessionTime: "3:30 PM"),
                Session(sessionTopic: "Economic Freedom", sessionDate: "2024-07-11", sessionCover: "economic_freedom.jpg", sessionTime: "11:00 AM"),
                Session(sessionTopic: "Economic Equity", sessionDate: "2024-07-16", sessionCover: "economic_equity.jpg", sessionTime: "4:00 PM")
            ],
            "John": [
                Session(sessionTopic: "Economic History", sessionDate: "2024-06-27", sessionCover: "economic_history.jpg", sessionTime: "9:00 AM"),
                Session(sessionTopic: "Economic Systems", sessionDate: "2024-07-02", sessionCover: "economic_systems.jpg", sessionTime: "1:00 PM"),
                Session(sessionTopic: "Economic Growth", sessionDate: "2024-07-07", sessionCover: "economic_growth.jpg", sessionTime: "2:30 PM"),
                Session(sessionTopic: "Economic Trends", sessionDate: "2024-07-12", sessionCover: "economic_trends.jpg", sessionTime: "10:30 AM"),
                Session(sessionTopic: "Economic Challenges", sessionDate: "2024-07-17", sessionCover: "economic_challenges.jpg", sessionTime: "3:00 PM")
            ]
    ]
    
    // Variables to store mentor and session data
    var mentor: Mentor?
    var sessions: [Session] = []


    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set table view data source and delegate
            table.dataSource = self
            table.delegate = self
            
            // Update UI with mentor details if available
            if let mentor = mentor {
                nameLabel.text = mentor.name
                designationLabel.text = mentor.designation + " Coach"
                profileImageView.image = UIImage(named: mentor.profile)
                followers.text = "\(mentor.followers)"
                interaction.text = " \(mentor.interaction)"
                experience.text = " \(mentor.experience)"
                likes.text = "\(mentor.likes)"
                MentorLabel.text = "\(mentor.description)"
                
                // Load sessions data for the selected mentor
                sessions = sessionData[mentor.name] ?? []
            }
            
            // Round the corners of the profile image view
            profileImageView.layer.cornerRadius = 10
            profileImageView.layer.masksToBounds = true
        }
        
        // MARK: - UITableViewDataSource
        
        // Number of rows in the table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sessions.count
        }
        
        // Configure and return cells for the table view
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! MentorTableViewCell
            let session = sessions[indexPath.row]
            
            // Configure the cell with session details
            cell.sessionLabel.text = session.sessionTopic
            cell.DateLabel.text = session.sessionDate
            cell.sessionImageView.image = UIImage(named: session.sessionCover)
            cell.timeLabel.text = session.sessionTime
            
            return cell
        }
}





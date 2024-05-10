//
//  PostViewController.swift
//  PostScreenLast
//
//  Created by student on 01/05/24.
//

import AVKit
import AVFoundation
import UIKit

// Custom AVPlayerViewController to handle pausing player when view disappears
class CustomAVPlayerViewController: AVPlayerViewController {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            player?.pause()
        }
    }
}


class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var table: UITableView! // Table view to display posts
    
    @IBOutlet weak var searchBar: UISearchBar! // Search bar for filtering posts
    // Struct to represent a post
    struct Posts {
        let subject: String
        let message: String
        let profile: String
        let author: String
    }
    var selectedSubject: String? // Currently selected subject
    var postsForSelectedSubject: [Posts] = [] // Posts corresponding to the selected subject
    
    // Dictionary to store posts for different subjects
    let data: [String: [Posts]] = [
        "English": [
            Posts(subject: "Tenses", message: "Dive into the complexities of English tenses and learn how to use them correctly in your writing. Mastering tenses is crucial for clear and effective communication. This post will guide you through the basics and advanced uses of tenses.", profile: "profile-1", author: "Marks John"),
            Posts(subject: "Shakespeare's Influence", message: "Explore how Shakespeare's works have shaped the English language and literature. Shakespeare's impact on English is profound. This post will highlight key phrases and expressions that have become part of our everyday language.", profile: "profile-2", author: "Chris Rocky"),
            Posts(subject: "Shakespeare's Hamlet ", message: "Delve into the depths of Shakespeare's Hamlet one of the most famous tragedies in English literature. Shakespeare's 'Hamlet' is a masterpiece of drama and language. This post will provide an in-depth analysis of the play's themes and characters.", profile: "profile-3", author: "Andrew Kim"),
            Posts(subject: "The Evolution of English Literature", message: "Trace the development of English literature from its origins to the present day. English literature has a rich history. This post will take you on a journey through the evolution of English literature, highlighting key authors and works.", profile: "profile-4", author: "Mathew Koleman"),
            // Add more posts for the English subject as needed
        ],
        "Science": [
            // Add posts for the Science subject
            Posts(subject: "The Big Bang Theory: Origins of the Universe", message: "The Big Bang theory provides insights into the formation of galaxies, stars, and the cosmic microwave background radiation. This post will explore the evidence supporting the Big Bang theory and its implications for our understanding of the cosmos.", profile: "profile-1", author: "Lucas Anderson"),
            Posts(subject: "The Quantum World: Where Reality Gets Weird", message: "Quantum mechanics revolutionized our understanding of the microscopic world, paving the way for technologies such as quantum computing and quantum cryptography. This post will introduce key concepts in quantum mechanics and explore their philosophical implications.", profile: "profile-1", author: "Ava Thompson"),
            Posts(subject: "The Human Genome Project: Decoding Our Genetic Blueprint", message: "The Human Genome Project has revolutionized our understanding of genetics and provided insights into the genetic basis of disease. This post will discuss the history, goals, and impact of the Human Genome Project on biomedical research and personalized medicine.", profile: "profile-2", author: "Noah Wilson"),
            Posts(subject: "Climate Change: Understanding the Science", message: "Climate change is driven by human activities such as burning fossil fuels and deforestation, leading to rising temperatures, melting ice caps, and extreme weather events. This post will examine the scientific evidence for climate change, its causes, and potential solutions to mitigate its effects.", profile: "profile-2", author: "Lily Johnson"),
        ],
        "History": [
            // Add posts for the History subject
            Posts(subject: "Ancient Civilizations", message: "Journey back in time to explore the wonders of ancient civilizations that laid the foundation for human society. From the majestic pyramids of Egypt to the enigmatic ruins of Machu Picchu, ancient civilizations continue to fascinate us with their cultural achievements and technological innovations.", profile: "profile-1", author: "Daniel Miller"),
            Posts(subject: "World War II: A Global Perspective", message: "Gain insights into the complexities of World War II from a global perspective. This conflict reshaped the political landscape and had far-reaching consequences for countries around the world. This post will examine key events, strategies, and the impact of the war on various nations.", profile: "profile-2", author: "Sophia Clark"),
            Posts(subject: "The Renaissance: Rebirth of Knowledge", message: "Explore the intellectual and cultural revival known as the Renaissance, a period of profound transformation in Europe. The Renaissance witnessed advancements in art, science, and philosophy that laid the groundwork for the modern world. This post will delve into the key figures, ideas, and artistic achievements of this remarkable era.", profile: "profile-2", author: "Benjamin Taylor"),
            Posts(subject: "Colonialism and Its Legacy", message: "Examine the complex legacy of colonialism and its enduring impact on societies across the globe. Colonialism reshaped economies, societies, and cultures, leaving a lasting imprint that continues to shape contemporary issues. This post will analyze the historical roots of colonialism, its consequences, and ongoing debates surrounding post-colonialism.", profile: "profile-3", author: "Olivia Wright"),
        ],
        "Mathematics": [
            Posts(subject: "The Beauty of Fractals", message: "Marvel at the intricate beauty of fractals, geometric shapes that exhibit self-similarity at different scales. Fractals are not only aesthetically pleasing but also have practical applications in fields such as computer graphics and chaos theory. This post will explore the fascinating world of fractals and their mathematical properties.", profile: "profile-1", author: "Nathan Harris"),
            Posts(subject: "Game Theory: Strategies for Success", message: "Dive into the realm of game theory and learn how mathematical principles can be applied to strategic decision-making. Game theory has applications in economics, political science, and evolutionary biology, offering valuable insights into competitive interactions. This post will introduce key concepts in game theory and illustrate their real-world applications through examples.", profile: "profile-1", author: "Victoria Martinez"),
            Posts(subject: "Prime Numbers: Nature's Building Blocks", message: "Discover the mysterious world of prime numbers, fundamental building blocks of arithmetic with unique properties. Prime numbers play a crucial role in cryptography, number theory, and computer science, making them objects of fascination for mathematicians throughout history. This post will unravel the secrets of prime numbers and explore their significance in various mathematical contexts.", profile: "profile-1", author: "Ethan Wilson"),
            Posts(subject: "Probability: Predicting the Future", message: "Explore the fascinating realm of probability theory and its applications in predicting uncertain outcomes. From weather forecasting to financial markets, probability theory provides a framework for understanding and quantifying uncertainty. This post will introduce fundamental concepts in probability theory and demonstrate their relevance through practical examples.", profile: "profile-1", author: "Isabella Garcia"),
        ],
        // Add posts for other subjects
        "Art": [
                // Add posts for the Art subject
                Posts(subject: "The Impressionist Movement", message: "Discover the revolutionary Impressionist movement that transformed the art world in the late 19th century. Impressionist artists captured fleeting moments of everyday life with vibrant colors and bold brushstrokes, breaking away from traditional academic conventions. This post will explore the key artists, techniques, and themes of Impressionism.", profile: "profile-3", author: "Sophie Evans"),
                Posts(subject: "Surrealism: Unleashing the Subconscious", message: "Explore the surreal world of Surrealism, an artistic movement that sought to unlock the power of the subconscious mind. Surrealist artists created dreamlike imagery that challenged conventional reality, blurring the boundaries between the conscious and unconscious realms. This post will delve into the origins, techniques, and major figures of Surrealism.", profile: "profile-4", author: "Elijah Thompson"),
                Posts(subject: "Baroque Art: Drama and Emotion", message: "Journey into the dramatic world of Baroque art, characterized by its grandeur, theatricality, and emotional intensity. Baroque artists infused their works with dynamic compositions, intense lighting, and expressive gestures to evoke powerful emotional responses. This post will explore the key features, artists, and masterpieces of the Baroque period.", profile: "profile-5", author: "Grace Miller"),
                Posts(subject: "Abstract Expressionism: Art of the Sublime", message: "Experience the raw emotional intensity of Abstract Expressionism, a movement that redefined the very nature of painting. Abstract Expressionist artists experimented with spontaneous gestures, bold colors, and gestural brushwork to convey deep emotions and existential truths. This post will delve into the origins, techniques, and major figures of Abstract Expressionism.", profile: "profile-6", author: "Liam Carter"),
            ],
            "Music": [
                // Add posts for the Music subject
                Posts(subject: "Classical Music: A Journey Through Time", message: "Embark on a musical journey through the rich history of classical music, from the Baroque era to the Romantic period and beyond. Classical music encompasses a diverse range of styles and compositions, each reflecting the cultural and artistic ideals of its time. This post will explore the evolution of classical music, highlighting key composers, genres, and masterpieces.", profile: "profile-1", author: "Emily Wright"),
                Posts(subject: "Jazz: America's Original Art Form", message: "Discover the vibrant world of jazz, a uniquely American musical genre that blends African rhythms, European harmonies, and improvisational techniques. Jazz has its roots in the African American experience and has evolved into a global phenomenon with diverse styles and influences. This post will trace the history of jazz, from its origins in New Orleans to its modern-day manifestations.", profile: "profile-2", author: "Mason Johnson"),
                Posts(subject: "Rock and Roll Revolution", message: "Explore the revolutionary impact of rock and roll on music and culture, from its roots in rhythm and blues to its explosive rise to popularity in the 1950s and beyond. Rock and roll has shaped generations of listeners and inspired countless artists with its rebellious spirit and infectious energy. This post will delve into the history, evolution, and enduring legacy of rock and roll.", profile: "profile-3", author: "Emma Davis"),
                Posts(subject: "Electronic Music: From Analog to Digital", message: "Trace the evolution of electronic music from its experimental beginnings to its widespread popularity in the digital age. Electronic music encompasses a wide range of genres and styles, from ambient and techno to dubstep and EDM. This post will explore the innovations, technologies, and artists that have shaped the electronic music landscape.", profile: "profile-4", author: "Landon Wilson"),
            ],
            "Geography": [
                // Add posts for the Geography subject
                Posts(subject: "Natural Wonders of the World", message: "Explore the awe-inspiring natural wonders that dot our planet, from majestic mountains and cascading waterfalls to vast deserts and lush rainforests. These geological formations and ecosystems showcase the incredible diversity and beauty of Earth's landscapes. This post will take you on a virtual tour of some of the most spectacular natural wonders around the globe.", profile: "profile-1", author: "Eva Thompson"),
                Posts(subject: "Climate Zones and Biomes", message: "Learn about the different climate zones and biomes that exist on Earth, each characterized by distinct weather patterns, vegetation, and wildlife. From tropical rainforests to polar tundras, climate zones and biomes play a crucial role in shaping the planet's ecosystems and biodiversity. This post will explore the factors that influence climate and the unique characteristics of each biome.", profile: "profile-2", author: "Oliver Martin"),
                Posts(subject: "Urbanization and Megacities", message: "Examine the phenomenon of urbanization and the rise of megacities, where millions of people converge to live and work in densely populated urban areas. Urbanization has profound social, economic, and environmental implications, shaping the way we live and interact with our surroundings. This post will discuss the causes and consequences of urbanization and explore the challenges facing megacities in the 21st century.", profile: "profile-3", author: "Sophia Garcia"),
                Posts(subject: "Geopolitics: Mapping Power and Influence", message: "Delve into the complex world of geopolitics, where nations compete for power, resources, and influence on the global stage. Geopolitical factors such as borders, natural resources, and strategic alliances shape international relations and geopolitics, influencing conflicts, trade, and diplomacy. This post will examine key geopolitical concepts and analyze current geopolitical issues and trends.", profile: "profile-4", author: "Daniel Brown"),
            ],
            "Economics": [
                // Add posts for the Economics subject
                Posts(subject: "Microeconomics: Understanding Markets", message: "Explore the principles of microeconomics, which focus on the behavior of individuals, firms, and industries in competitive markets. Microeconomics examines how supply and demand determine prices and quantities of goods and services, as well as the allocation of resources. This post will introduce key microeconomic concepts and illustrate their real-world applications through examples.", profile: "profile-1", author: "Aiden Martinez"),
                Posts(subject: "Macroeconomics: Analyzing the Economy", message: "Gain insights into the broader workings of the economy with macroeconomics, which studies aggregate phenomena such as inflation, unemployment, and economic growth. Macroeconomists analyze factors that influence the overall performance of the economy and develop policies to achieve macroeconomic objectives. This post will explore key macroeconomic concepts and theories, providing a framework for understanding the economy as a whole.", profile: "profile-2", author: "Ava Thompson"),
                Posts(subject: "International Trade and Globalization", message: "Examine the interconnected world of international trade and globalization, where goods, services, and capital flow across national borders. International trade and globalization have reshaped economies, industries, and societies, creating both opportunities and challenges. This post will discuss the theories of international trade, the benefits and costs of globalization, and the role of international organizations in shaping global trade relations.", profile: "profile-3", author: "Liam Wilson"),
                Posts(subject: "Development Economics: Bridging the Wealth Gap", message: "Explore the field of development economics, which focuses on understanding the economic challenges facing developing countries and regions. Development economists study factors that contribute to economic growth, poverty reduction, and sustainable development, seeking to identify policies and strategies that can improve living standards and promote inclusive growth. This post will examine key issues in development economics and highlight successful development initiatives from around the world.", profile: "profile-4", author: "Emma Davis"),
            ],
            "Physics": [
                // Add posts for the Physics subject
                Posts(subject: "The Theory of Relativity: Understanding Spacetime", message: "Dive into the mind-bending world of Einstein's theory of relativity, which revolutionized our understanding of space, time, and gravity. The theory of relativity has profound implications for our conception of the universe, from the behavior of black holes to the nature of time dilation. This post will explore the key concepts of relativity theory and their implications for modern physics.", profile: "profile-1", author: "Lucas Anderson"),
                Posts(subject: "Quantum Field Theory: The Fabric of Reality", message: "Explore the fundamental forces and particles that make up the fabric of reality with quantum field theory. Quantum field theory provides a framework for understanding the behavior of particles and their interactions through the exchange of force-carrying particles. This post will introduce key concepts in quantum field theory and discuss its role in our current understanding of the universe.", profile: "profile-2", author: "Nathan Harris"),
                Posts(subject: "Astrophysics: Exploring the Cosmos", message: "Embark on a cosmic journey through the field of astrophysics, where scientists study the origins, evolution, and fate of the universe. Astrophysics encompasses a wide range of phenomena, from the formation of galaxies and stars to the behavior of black holes and dark matter. This post will explore the key topics and discoveries in astrophysics, shedding light on the mysteries of the cosmos.", profile: "profile-3", author: "Sophia Clark"),
                Posts(subject: "Particle Physics: Probing the Subatomic World", message: "Delve into the strange and fascinating world of particle physics, where scientists study the smallest building blocks of matter and the fundamental forces of nature. Particle physics seeks to unravel the mysteries of the subatomic realm, from the properties of quarks and leptons to the nature of dark matter and dark energy. This post will explore the cutting-edge research and experiments driving our understanding of particle physics.", profile: "profile-4", author: "Oliver Martin"),
            ],
            "Chemistry": [
                // Add posts for the Chemistry subject
                Posts(subject: "The Periodic Table: A Guide to the Elements", message: "Discover the periodic table, a systematic arrangement of the chemical elements that provides insights into their properties and behaviors. The periodic table is a foundational tool in chemistry, organizing elements based on their atomic structure and chemical properties. This post will explore the history, structure, and significance of the periodic table.", profile: "profile-1", author: "Ethan Wilson"),
                Posts(subject: "Chemical Reactions: From Reactants to Products", message: "Explore the fascinating world of chemical reactions, where atoms rearrange to form new substances with unique properties. Chemical reactions play a crucial role in everyday life, from the combustion of fuels to the synthesis of pharmaceuticals. This post will introduce the basic principles of chemical reactions and explore their applications in various fields.", profile: "profile-2", author: "Isabella Garcia"),
                Posts(subject: "Organic Chemistry: The Chemistry of Carbon", message: "Delve into the intricate world of organic chemistry, which focuses on the study of carbon-containing compounds. Organic chemistry is essential for understanding life processes, as carbon-based molecules form the basis of biological systems. This post will explore the structure, properties, and reactions of organic compounds, from simple hydrocarbons to complex biomolecules.", profile: "profile-3", author: "Landon Wilson"),
                Posts(subject: "Chemical Bonding: The Glue of Matter", message: "Learn about the forces that hold atoms together to form molecules and compounds with chemical bonding. Chemical bonding determines the structure and properties of matter, influencing its physical and chemical behaviors. This post will explore the different types of chemical bonds, such as covalent, ionic, and metallic bonds, and their significance in chemistry.", profile: "profile-4", author: "Eva Thompson"),
            ]
    ]
    var filteredPosts: [Posts] = [] // Stores search results
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNavigationBarHidden(false, animated: false)
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        
        // Load posts for the selected subject
        if let selectedSubject = selectedSubject {
            if let posts = data[selectedSubject] {
                postsForSelectedSubject = posts
                filteredPosts = posts // Initially show all posts for the selected subject
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return postsForSelectedSubject.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
                
                let post = postsForSelectedSubject[indexPath.row]
                
                // Set cell content based on the selected post
                cell.subjectLabel.text = post.subject
                cell.messageLabel.text = post.message
                cell.profileImageView.image = UIImage(named: post.profile)
                cell.authorLabel.text = post.author
                
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // Set the height of each row
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playVideo() // Play video when a row is selected
    }
    
// MARK: - Video Playback
    func playVideo() {
        var playerViewController: CustomAVPlayerViewController?
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Tenses", ofType: "mp4")!))
        
        let vc = CustomAVPlayerViewController()
        vc.player = player
        playerViewController = vc // Retain a reference to CustomAVPlayerViewController
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredPosts.count // Return the number of rows based on the number of filtered posts
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPosts = postsForSelectedSubject.filter { post in
                post.subject.lowercased().contains(searchText.lowercased())
            }
            if searchText.isEmpty {
                filteredPosts = postsForSelectedSubject // Reset to all posts if search bar is empty
            }
            table.reloadData() // Reload table view to reflect changes
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

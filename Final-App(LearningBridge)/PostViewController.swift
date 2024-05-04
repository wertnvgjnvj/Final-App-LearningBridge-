//
//  PostViewController.swift
//  PostScreenLast
//
//  Created by student on 01/05/24.
//

import UIKit

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    struct Posts {
        let subject: String
        let message: String
        let profile: String
        let author: String
    }
    
    let data: [Posts] = [
        Posts(subject: "Tenses", message: "Dive into the complexities of English tenses and learn how to use them correctly in your writing. Mastering tenses is crucial for clear and effective communication. This post will guide you through the basics and advanced uses of tenses.", profile: "profile-1", author: "Marks John"),
        Posts(subject: "Shakespeare's Influence", message: "Explore how Shakespeare's works have shaped the English language and literature. Shakespeare's impact on English is profound. This post will highlight key phrases and expressions that have become part of our everyday language.", profile: "profile-2", author: "Chris Rocky"),
        Posts(subject: "Shakespeare's Hamlet ", message: "Delve into the depths of Shakespeare's Hamlet one of the most famous tragedies in English literature. Shakespeare's 'Hamlet' is a masterpiece of drama and language. This post will provide an in-depth analysis of the play's themes and characters.", profile: "profile-3", author: "Andrew Kim"),
        Posts(subject: "The Evolution of English Literature", message: "Trace the development of English literature from its origins to the present day. English literature has a rich history. This post will take you on a journey through the evolution of English literature, highlighting key authors and works.", profile: "profile-4", author: "Mathew Koleman"),
        Posts(subject: "Tenses", message: "Dive into the complexities of English tenses and learn how to use them correctly in your writing. Mastering tenses is crucial for clear and effective communication. This post will guide you through the basics and advanced uses of tenses.", profile: "profile-1", author: "Marks John"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNavigationBarHidden(false, animated: false)
        table.dataSource = self
        table.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        cell.subjectLabel.text = user.subject
        cell.messageLabel.text = user.message
        cell.authorLabel.text = user.author
        cell.profileImageView.image = UIImage(named: user.profile)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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

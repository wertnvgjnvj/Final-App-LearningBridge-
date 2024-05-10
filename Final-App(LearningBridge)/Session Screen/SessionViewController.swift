//
//  SessionViewController.swift
//  sessionpage
//
//  Created by Sahil Aggarwal on 01/05/24.
//

import UIKit
// This class manages the session view, displaying a list of social activities with authors and titles, and providing search functionality to filter the displayed data.
class SessionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
    // Outlet for the search bar used to filter social activities.
    @IBOutlet weak var searchBar: UISearchBar!
    // Outlet for the table view displaying social activities.
    @IBOutlet weak var table: UITableView!
    
    // Structure representing a social activity with author, image, and title.
    struct Social{
        let auth : String // Author of the social activity
        let image : String // Image representing the activity
        let title : String // Title of the social activity
    }
    
    // Array containing social activities data.
    let data: [Social] = [
        Social(auth:"Evaluate English",image:"pic-1",title:"Mark Jones"),
        Social(auth: "Talk with me", image: "pic-2", title: "Mark Jones"),
        Social(auth: "Make English Fun", image: "pic-3", title: "Mark Jones"),
        Social(auth: "Speak English", image: "pic-4", title: "Mark Jones"),
        Social(auth: "Practice English", image: "pic-5", title: "Mark Jones"),
        Social(auth: "Develop Skills", image: "pic-6", title: "Mark Jones"),
        Social(auth: "Just For Fun", image: "pic-7", title: "mark Jones")]
    
    var filteredData: [Social] = [] // Filtered social activities based on search
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set table view data source and delegate
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self // Set search bar delegate
        filteredData = data // Initialize filtered data with all social activities
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = filteredData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SessionTableViewCell
        cell.author.text = user.auth
        cell.head.text = user.title
        cell.poster.image = UIImage(named: user.image)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // Set height for table view rows
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter data based on search text and reload table view to reflect changes
        filteredData = data.filter { social in
            social.auth.lowercased().contains(searchText.lowercased()) ||
                social.title.lowercased().contains(searchText.lowercased())
        }
        table.reloadData() // Reload table view to reflect changes
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

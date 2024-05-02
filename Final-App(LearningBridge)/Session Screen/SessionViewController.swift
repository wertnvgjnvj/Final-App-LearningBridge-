//
//  SessionViewController.swift
//  sessionpage
//
//  Created by Sahil Aggarwal on 01/05/24.
//

import UIKit

class SessionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var table: UITableView!
    
    struct Social{
        let auth : String
        let image : String
        let title : String
    }
    let data: [Social] = [ Social(auth:"Evaluate English",image:"pic-1",title:"Mark Jones"),Social(auth: "Talk with me", image: "pic-2", title: "Mark Jones"),Social(auth: "Make English Fun", image: "pic-3", title: "Mark Jones"),Social(auth: "Speak English", image: "pic-4", title: "Mark Jones"),Social(auth: "Practice English", image: "pic-5", title: "Mark Jones"),Social(auth: "Develop Skills", image: "pic-6", title: "Mark Jones"),Social(auth: "Just For Fun", image: "pic-7", title: "mark Jones")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SessionTableViewCell
        cell.author.text = user.auth
        cell.head.text = user.title
        cell.poster.image = UIImage(named: user.image)
   return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60   }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

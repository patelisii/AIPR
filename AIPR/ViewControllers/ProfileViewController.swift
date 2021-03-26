//
//  ProfileViewController.swift
//  AIPR
//
//  Created by Patrick Elisii on 3/22/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var numberItemsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var recycleProgressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = PFUser.current()
        usernameLabel.text = user?.username as! String
        setProgressBar()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        setProgressBar()
    }
    
    func setProgressBar(){
        let user = PFUser.current()
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = 20
        query.whereKey("author", equalTo: user)
        
        var items: [PFObject]
        items = []
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil{
                items = posts!
                
                self.recycleProgressView.progress = Float(items.count)/50.0
                self.numberItemsLabel.text = "Items Recycled: \(items.count)"
            }
            else{
                items = []
            }
        }
    }
    
    
    
    @IBAction func onSignOut(_ sender: Any) {
        
        PFUser.logOut()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(loginViewController, animated: true, completion: nil)
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

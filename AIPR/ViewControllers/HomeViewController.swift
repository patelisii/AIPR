//
//  HomeViewController.swift
//  AIPR
//
//  Created by Patrick Elisii on 2/28/21.
//

import UIKit
import SideMenu
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MenuControllerDelegate{
    
    var localStandardsController = LocalStandardsViewController()

    @IBOutlet weak var tableView: UITableView!
    var picture = UIImage()
    var posts = [PFObject]()
    private var sideMenu: SideMenuNavigationController?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        refreshData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        
        let menu = MenuTableViewController(with: ["Home",
                                                  "Settings"
                                                  ])
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
//        addChildControllers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshData()
    }
    
    
    @objc func refreshData(){
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = 30
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.posts.reverse()
                self.tableView.reloadData()
            }
        }
        self.refreshControl.endRefreshing()
        
    }
    
    @objc func getType(){
        
    }
    
    private func addChildControllers(){
        //do each step for every view controller
        print("fail 1")
        addChild(localStandardsController)
        print("fail 2")
        view.addSubview(localStandardsController.view)
        print("fail 3")
        localStandardsController.view.frame = view.bounds
        print("fail 4")
        localStandardsController.didMove(toParent: self)
        print("fail 5")
        localStandardsController.view.isHidden = true
    }
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [self] in
            
//            self.title = named
            
            if named == "Home"{
                self.view.isHidden = false
//                localStandardsController.view.isHidden = true
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        let name = user.username as! String
        let item = post["item"] as! String
        let conf = post["confidence"] as! String
        cell.postLabel.text = name + " recycled " + item + " with a confidence of " + conf
        let imageLabel = post["image_label"] as! String
        cell.proPicImageView.image = UIImage(named: imageLabel)
//        let proPic = post["profile_picture"] as! String
//        print(type(of: proPic))
//        if proPic != nil{
//            cell.proPicImageView.image = UIImage(named: proPic)
//        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func didTapMenuButton(_ sender: Any) {
        present(sideMenu!, animated: true)
    }
    
    @IBAction func didTapButton(){

//        let picker = UIImagePickerController()
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            picker.sourceType = .camera
//        }
//        else{
//            picker.sourceType = .photoLibrary
//        }
//        picker.delegate = self
//        present(picker, animated: true)
    }
        
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true)

        if(info[UIImagePickerController.InfoKey.originalImage] != nil){
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.picture = image
            
            self.performSegue(withIdentifier: "showResults", sender: self)
        }
        else{
            return
        }
        
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showResults"{
//            var resultsViewController = ResultsViewController()
//            resultsViewController = segue.destination as! ResultsViewController
//            resultsViewController.pic = self.picture as! UIImage
        }
        else if segue.identifier == "showInfo"{
            var infoViewController = LocalStandardsViewController()
            infoViewController = segue.destination as! LocalStandardsViewController
        }

        
    }
    
}


//
//  ResultsViewController.swift
//  AIPR
//
//  Created by Patrick Elisii on 3/2/21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var pic = UIImage()
    @IBOutlet weak var imageFrame: UIImageView!
    
    @IBAction func dispose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFrame.image = pic
        
        // Do any additional setup after loading the view.
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

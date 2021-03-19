//
//  LocalStandardsViewController.swift
//  AIPR
//
//  Created by Patrick Elisii on 3/14/21.
//

import UIKit

class LocalStandardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var localtableView: UITableView!
    var library = [[
        "type": "Batteries and Bulbs",
        "preview": "Some batteries and bulbs can be recycled. Check out our Batteries & Bulbs Fact Sheet for more information.",
        "image": "batteries-bulbs-poster",
        "url": "https://www.centrecountyrecycles.org/index.asp?SEC=85B24A99-4657-470E-BE67-90775D02F24C"],
        ["type": "Business/Office Recycling",
         "preview": "Business and office recycling is mandatory in State College and Bellefonte Boroughs, the surrounding Townships in the Centre Region as well as Benner & Spring Townships. Our Commercial Recycling specialists can: Help identify recyclable materials, Suggest waste reduction tips, Provide assistance in obtaining recycling containers, Train your employees, Conduct a free waste assessment, Provide free education material and signage",
         "image": "business-poster",
         "url": "https://www.centrecountyrecycles.org/businessrecycling"],
        ["type": "Curbside Recycling",
         "preview": "Residents should have recycling bins and trash containers set out by the time pickup crews begin collection at 7:00 a.m. Curbside recycling collection is done weekly, on the same day as trash pickup.",
         "image": "curbside-poster",
         "url": "https://www.centrecountyrecycles.org/curbsiderecycling"],
        ["type": "Drop Off Recycling",
         "preview": "Centre County has recycling drop off locations for residents to use for recycling various materials. These drop-offs are available 24 hours a day, 7 days a week. Most locations are equipped with compartmentalized containers handling six categories of materials.",
         "image": "drop-off-poster",
         "url": "https://www.centrecountyrecycles.org/dropoffrecycling"],
        ["type": "Electronics Recycling",
         "preview": "Act 108 of 2010 (The Covered Device Recycling Act), bans all covered devices from landfills, however, the Centre County Recycling & Refuse Authority offers a free drop off service for residents.  Covered Devices includes desktop computers, monitors, laptops, computer peripherals and televisions. ",
         "image": "electronics-poster",
         "url": "https://www.centrecountyrecycles.org/electronicsrecycling"],
        ["type": "Misc. Plastics Recycling",
         "preview": "Although we do not accept miscellaneous plastic containers curbside, we do provide six locations to recycle items such as: yogurt containers, margarine containers, strawberry/blueberry/lettuce containers, etc. If a container does not fit in the Miscellaneous Plastic drop off box, please do not leave the container outside of the box.",
         "image": "misc-plastics-poster",
         "url": "https://www.centrecountyrecycles.org/plasticsrecycling"],
        
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        localtableView.dataSource = self
        localtableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as! InfoTableViewCell
        
        let info = self.library[indexPath.row] as! [String:Any]
        
        cell.typeLabel.text = info["type"] as! String
        cell.previewLabel.text = info["preview"] as! String
        cell.itemImage.image = UIImage(named: info["image"] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myUrl = library[indexPath.row]["url"] as! String
        let url = (URL(string: myUrl) ?? URL(string: "https://www.centrecountyrecycles.org/"))!
        UIApplication.shared.open(url)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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

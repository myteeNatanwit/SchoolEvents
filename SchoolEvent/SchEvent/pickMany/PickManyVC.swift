//
//  PickMany.swift
//  SchoolEvents
//
//  Created by Admin on 25/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import UIKit

protocol PickManyDelegate {
    func childReturn(data: [infoType]);
}
class PickManyVC: UIViewController  {
    @IBAction func addBtnClk(_ sender: Any) {
        switchViewControllersItem(Name: "AddSmthng");
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func doneBtnClk(_ sender: UIBarButtonItem) {
        
        paramData = currentArray;
        print("Done " + paramData.count.description);
        delegate?.childReturn(data: paramData); // let caller know the slection is done with input param array
    }
    @IBAction func pickedToggle(_ sender: UISwitch) {
        currentArray[sender.tag].picked = sender.isOn;
        paramData[sender.tag].picked = sender.isOn;
    }
    var delegate : PickManyDelegate?
    var paramData: [infoType] = [];
    var currentArray: [infoType] = []; // for search result
    // Search Bar

   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar;
        switch editChoice {
        case editType.organiser:
           self.navigationItem.title = "Organisers";
        case editType.participant:
            self.navigationItem.title = "Participants";
        default:
            return;
        }

        currentArray = paramData;
        tableView.dataSource = self;
        tableView.delegate = self;
        searchBar.delegate = self;
        searchBar.isHidden = true; // bug, hide it for now;
        // Do any additional setup after loading the view.
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

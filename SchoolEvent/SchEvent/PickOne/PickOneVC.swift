//
//  PickOneVC.swift
//  SchoolEvents
//
//  Created by Admin on 26/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import UIKit
protocol PickOneDelegate {
    func childReturn(data: infoType);
}
class PickOneVC: UIViewController ,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addBtnClk(_ sender: Any) {
        switchViewControllersItem(Name: "AddSmthng")
        
    }
    var delegate : PickOneDelegate?
    var paramData: [infoType] = [];
    var currentArray: [infoType] = []; // for search result
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            currentArray = paramData;
            tableView.reloadData()
            return;
        }
        currentArray = paramData.filter({ element -> Bool in
            return element.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickOne")// as? UITableViewCell;
        
        cell?.textLabel?.text = currentArray[indexPath.row].title
        cell?.detailTextLabel?.text = currentArray[indexPath.row].sub;

        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!");
        let info = infoType(title: currentArray[indexPath.row].title, sub: currentArray[indexPath.row].sub, picked: false);
        msgBox(mytitle: "SchoolEvent", mymessage: "Adding " + info.title + " to your Event?") {
            print("ok pressed");
            self.delegate?.childReturn(data: info);
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar;
        //   let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped));
        //  navigationItem.rightBarButtonItems = [doneBtn];
        if paramData.count == 0 {
            paramData = [
                infoType(title:"aa",sub:"aaa", picked:false),
                infoType(title:"aa2",sub:"aaa2",picked:false),
                infoType(title:"bb3",sub:"bbb3",picked:false),
                infoType(title:"aa3",sub:"aaa3",picked:true)];
        }
        currentArray = paramData;
        tableView.dataSource = self;
        tableView.delegate = self;
        searchBar.delegate = self;
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

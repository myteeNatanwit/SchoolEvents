//
//  ParticipateVC.swift
//  SchoolEvents
//
//  Created by Admin on 29/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import UIKit
protocol ParticipateDelegate {
    func childParReturn(_ data: infoType);
}
class ParticipateVC: UITableViewController {
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var roleTxt: UITextField!
    @IBAction func addBtnClk(_ sender: UIButton) {
        print("Save");
        if validateParticipateEntry() {
            let par = Participant(context: context); // new one
            par.name = nameTxt.text;
            par.role = roleTxt.text;
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            delegate?.childParReturn(infoType(title: par.name!, sub: par.role!, picked: false));
        }
    }
    var delegate: ParticipateDelegate?

    func validateParticipateEntry() -> Bool {
        // not empty
        if nameTxt.text == "" || roleTxt.text == "" {
            alert(title: "Participant", message: "Incomplete Entry!")
            return false;
        }
        let pars = participants as [Participant];
        if pars.contains(where: { $0.name == nameTxt.text }) // no dup key
            {
            alert(title: "Participant", message: "Duplicate Name!");
            return false;
        }
        return true;
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

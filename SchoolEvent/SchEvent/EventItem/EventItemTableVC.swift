

import UIKit
import CoreData
import MapKit

protocol eventItemDelegate {
    func eventItemReturn(_ data: String)
}
class EventItemTableVC: UITableViewController {
    @IBOutlet weak var dateTimeVal: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var longDesc: UITextView!

    @IBOutlet weak var loc: UILabel!
    @IBOutlet weak var cat: UILabel!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var feeVal: UITextField!

    var delegate: eventItemDelegate?
    var PickOneData: [infoType] = []; // for pickone param
    var PickManyData: [infoType] = []; // for pickone param
    var paticipantArray: [Participant] = []; // store user selection
    var organiserArray: [Organiser] = []; // store user selection
    var paramID = "";
    var editEventIndex = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Event";
        refreshData();
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped));
        navigationItem.rightBarButtonItems = [doneBtn];
    }

    func refreshData() {
        id.text = paramID.isEmpty ? (Date() as NSDate).toString(dateFormat: "yymmddhhmmss") : paramID;
        if paramID == "" {
            cat.text = ""; // clear data for validation
            loc.text = "";
            feeVal.text = "";
            dateTimeVal.text = "";
            paticipantArray = [];
            organiserArray = [];
        } else {
            let event = events[editEventIndex];
            cat.text = event.category?.name;
            loc.text = event.address;
            feeVal.text = event.fee.description;
            dateTimeVal.text = event.dateTime?.toString(dateFormat: "HH:mm dd/MM/YYYY");
            desc.text = event.desc;
            longDesc.text = event.detail;
            paticipantArray = event.paticipateBy?.allObjects as! [Participant];
            organiserArray = event.organiserBy?.allObjects as! [Organiser];
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    func getCat(_ id: String) -> Category {
        let cats = categories as [Category]; // convert to array
        let cat = cats.first(where: { $0.name == id });
        return cat!;
    }
    func getParticipant(_ id: String) -> Participant {
        let pars = participants as [Participant];
        return pars.first(where: { $0.name == id })!;
    }
    func getOrganiser(_ id: String) -> Organiser {
        let orgs = organisers as [Organiser]; // convert to array
        return orgs.first(where: { $0.name == id })!;
    }
    @objc func doneTapped() {
        print("Done ");
        if validateEvent() {
            var newEvent = events[editEventIndex];
            if paramID == "" {
                newEvent = Event(context: context);
            }
            newEvent.id = id.text;
            newEvent.desc = desc.text;
            newEvent.address = loc.text;
            newEvent.fee = (feeVal.text! as NSString).floatValue ;
            newEvent.status = "Open";
            newEvent.detail = longDesc.text;
            //    newEvent.distance = 14;
            newEvent.dateTime = toDate(dateTimeVal.text!) as NSDate;
            // pointer section
            newEvent.paticipateBy = nil;

            newEvent.category = getCat(cat.text!);
            for i in paticipantArray {
                newEvent.addToPaticipateBy(i);
            }
            newEvent.organiserBy = nil;
            for i in organiserArray {
                newEvent.addToOrganiserBy(i);
            }
            // calculate distance
            let city = filteredData.first(where: { $0.name == loc.text })!;
            newEvent.lat = CLLocationDegrees(city.latlon.lat);
            newEvent.lon = CLLocationDegrees(city.latlon.lon);
            print(city.latlon.lat, " ", city.latlon.lon);

            let schs = schools as [School];
            let thisSchool = schs[0];
            let location1 = CLLocation(latitude: CLLocationDegrees(newEvent.lat), longitude: CLLocationDegrees(newEvent.lon))
            let location2 = CLLocation(latitude: thisSchool.lat, longitude: thisSchool.lon);

            let distance: CLLocationDistance = location1.distance(from: location2)
            newEvent.distance = distance / 1000;
            print(thisSchool.lat, " - ", thisSchool.lon);
            print("distance = \(distance) m");

            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            delegate?.eventItemReturn("done");
        } else {
            alert(title: "Event", message: "Data incomplete!")
        }

    }

    func validateEvent() -> Bool {
        if (cat.text?.isEmpty)! { return false; } //
        if (loc.text?.isEmpty)! { return false; }
        if (dateTimeVal.text?.isEmpty)! { return false; }
        if (desc.text?.isEmpty)! { return false; }
        if organiserArray.count == 0 { return false; }
        if paticipantArray.count == 0 { return false; }

        //       let evs = events as [Event];
        //        if !evs.contains(where: { $0.id == id.text }) { // no dup


        return true;
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.sendAction("resignFirstResponder", to:nil, from:nil, for:nil)
        

        print("You selected cell number: \(indexPath.row)!");
        switch indexPath.row {
        case 1:
            editChoice = editType.cat;
            switchViewControllerPickOne(Name: "PickOne");
        case 2:
            showDateTimePicker(sender: self);
        case 3: editChoice = editType.organiser;
            switchViewControllerPickMany(Name: "PickMany");
        case 4: editChoice = editType.participant;
            switchViewControllerPickMany(Name: "PickMany");
        case 5:
            switchViewControllersSearch(Name: "SearchView", thisData: filteredData);
        default:
            return;
        }

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

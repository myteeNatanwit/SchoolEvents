
import UIKit
/*
 
 if switchControl.isOn {
 let center = UNUserNotificationCenter.current()
 center.requestAuthorization(options: [.alert, .sound]) {
 granted, error in
 // do nothing
 }
 }
 */
class EventListVC: UIViewController{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var currentArray:[Event] = [];
    @IBAction func addBtnClk(_ sender: Any) {
        addViewControllersItem(Name: "EventItem");
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar;
        getData();
        if events.count == 0 {
            makeDummyData();
        }
        currentArray = events;
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self;
        DispatchQueue.global().async {
            rawData = loadJson(filename: "citylist")!; // background loading city names n location
        }
    }

    override func viewWillAppear(_ animated: Bool) {
    }

   

}



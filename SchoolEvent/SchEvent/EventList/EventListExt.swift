//
//  EventListExt.swift
//  SchoolEvents
//
//  Created by Admin on 26/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import Foundation
import UIKit
import CoreData



extension EventListVC: UISearchBarDelegate {
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentArray = events.filter({ paramData -> Bool in
            if searchText.isEmpty { return true }
            return paramData.desc!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }}
extension EventListVC: eventItemDelegate {
    func eventItemReturn(_ data: String) {
        print("return");
        do {
            events = try context.fetch(Event.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
        tableView.reloadData();
        navigationController?.popViewController(animated: true)
    }

    func addViewControllersItem(Name: String) {
        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        
        let nav = storyboard.instantiateViewController(withIdentifier: Name) as! EventItemTableVC
        nav.delegate = self;
        nav.paramID = "";
        navigationController?.pushViewController(nav, animated: true)
    }
}
extension EventListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count; //events.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell") as? EventListCell else {
            return UITableViewCell()
        }
        let event = currentArray[indexPath.row];
        cell.desc.text = event.desc;
        cell.fee.text = event.fee.description;
        cell.loc.text = event.address;
        let org = event.organiserBy?.allObjects as! [Organiser];
        if org.count != 0 {
            cell.organiser.text = "By: " + (org.first?.name)!;
            print(org.first?.name);
        }
        let cat = event.category;
        cell.category.text = cat?.name;
        cell.status.text = event.status;
        cell.dateTime.text = event.dateTime?.toString(dateFormat: "HH:mm dd/MM/YYYY")
        cell.distance.text = String(format: "%.2f", ceil(event.distance*100)/100) + "Km";
        return cell;
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let event = events[indexPath.row]
            context.delete(event)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                events = try context.fetch(Event.fetchRequest())
            }
            catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!");
        let storyboard = UIStoryboard.init(name: "EventItem", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "EventItem") as! EventItemTableVC
        nav.delegate = self;
        nav.editEventIndex = indexPath.row;
        nav.paramID = events[indexPath.row].id!;
        navigationController?.pushViewController(nav, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)

    }
}

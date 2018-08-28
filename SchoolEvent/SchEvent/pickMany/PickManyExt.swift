//
//  PickManyExt.swift
//  SchoolEvents
//
//  Created by Admin on 27/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import Foundation
import UIKit
extension PickManyVC:AddSmthngDelegate {
    func childReturn(_ data: String) {
        print(data);
        if !paramData.contains(where: { $0.title == data }) {
            paramData.append(infoType(title: data, sub: "Admin", picked: false))
            // Mark: TODO
            switch editChoice {
            case editType.organiser:
                let org = Organiser(context: context);
                org.name = data;
                org.role = "Admin";
            case editType.participant:
                let par = Participant(context: context);
                par.name = data;
                par.role = "Guest";
            default: return;
            }
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
        currentArray = paramData;
        tableView.reloadData();
        navigationController?.popViewController(animated: true)
    }
    func switchViewControllersItem(Name: String) {
        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Name) as! AddSmthng
        nav.delegate = self;
        navigationController?.pushViewController(nav, animated: true)
    }
    
}

extension PickManyVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PickManyCell else {
            return UITableViewCell()
        }
        cell.title.text = currentArray[indexPath.row].title
        cell.sub.text = currentArray[indexPath.row].sub;
        cell.picked.tag = indexPath.row;
        cell.picked.isOn = currentArray[indexPath.row].picked;
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!");
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
extension PickManyVC: UISearchBarDelegate{
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
    
}

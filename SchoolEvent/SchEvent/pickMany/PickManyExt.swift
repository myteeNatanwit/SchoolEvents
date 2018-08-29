//
//  PickManyExt.swift
//  SchoolEvents
//
//  Created by Admin on 27/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import Foundation
import UIKit

extension PickManyVC: OrganiserDelegate {
    func childOrgReturn(_ data: infoType) {
        if !paramData.contains(where: { $0.title == data.title }) {
            paramData.append(data);

            currentArray = paramData;
            tableView.reloadData();
            navigationController?.popViewController(animated: true)
        }
    }
        func AddOrganiser() {
            let storyboard = UIStoryboard.init(name: "OrganiserVC", bundle: nil)
            let nav = storyboard.instantiateViewController(withIdentifier: "OrganiserVC") as! OrganiserVC
            nav.delegate = self;
            navigationController?.pushViewController(nav, animated: true)
        }

    }

extension PickManyVC: ParticipateDelegate {
    func childParReturn(_ data: infoType) {
        if !paramData.contains(where: { $0.title == data.title }) {
            paramData.append(data);
            
            currentArray = paramData;
            tableView.reloadData();
            navigationController?.popViewController(animated: true)
        }
    }

    func AddParticipant() {
        let storyboard = UIStoryboard.init(name: "ParticipateVC", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "ParticipateVC") as! ParticipateVC
         nav.delegate = self;
        navigationController?.pushViewController(nav, animated: true);
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
    extension PickManyVC: UISearchBarDelegate {
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

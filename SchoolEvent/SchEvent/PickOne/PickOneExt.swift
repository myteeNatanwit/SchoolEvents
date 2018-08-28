//
//  PickOneExt.swift
//  SchoolEvents
//
//  Created by Admin on 26/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//


import Foundation
import UIKit
import CoreData

extension PickOneVC: AddSmthngDelegate {
    func childReturn(_ data: String) {
        print(data);
        if !paramData.contains(where: { $0.title == data }) {
         paramData.append(infoType(title: data, sub: "", picked: false))
            if editChoice == editType.cat {
            //save new category
            let newCat = Category(context: context);
                newCat.name = data;
                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
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

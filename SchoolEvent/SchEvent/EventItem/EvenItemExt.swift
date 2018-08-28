//
//  EvenItemExt.swift
//  SchoolEvents
//
//  Created by Admin on 25/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import Foundation
import UIKit

extension EventItemTableVC: PickOneDelegate {
            
    func childReturn(data: infoType) {
        print("returned")
        cat.text = data.title;
        navigationController?.popViewController(animated: true);
    }
    func prepareData() {
        PickOneData = []; // reset
        switch editChoice {
        case editType.cat:
            do {
                categories = try context.fetch(Category.fetchRequest()); // refesh cat
            }
            catch {
                print("Fetching Failed")
            }
            let cats = categories as [Category]; // convert to array
            for cat in cats {
                PickOneData.append(infoType(title: cat.name!, sub: "", picked: false));
            }
        
        default: return;
        }
    }
    func switchViewControllerPickOne(Name: String) {
        prepareData();
        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Name) as! PickOneVC;
        nav.delegate = self;
        nav.paramData = PickOneData;
        navigationController?.pushViewController(nav, animated: true)
    }
}
    extension EventItemTableVC: PickManyDelegate {
        
        func childReturn(data: [infoType]){
           
            PickManyData = data;
            print("returned " + PickManyData.count.description);
            switch editChoice {
            case editType.organiser:
                do {
                    organisers = try context.fetch(Organiser.fetchRequest()); // refesh cat
                }
                catch {
                    print("Fetching Failed")
                }
                
                for i in PickManyData {
                    if i.picked {
                        organiserArray.append(getOrganiser(i.title))
                    }
                }
            case editType.participant:
                
                do {
                    participants = try context.fetch(Participant.fetchRequest()); // refesh cat
                }
                catch {
                    print("Fetching Failed")
                }
              
                for i in PickManyData {
                    if i.picked {
                        paticipantArray.append(getParticipant(i.title))
                    }
                }
            default: return;
            }
            navigationController?.popViewController(animated: true);
            
        }
        func prepareDataPickMany() {
            PickManyData = [];
            
            switch editChoice {
            case editType.organiser:
                
                do {
                    organisers = try context.fetch(Organiser.fetchRequest()); // refesh cat
                }
                catch {
                    print("Fetching Failed")
                }
                let orgs = organisers as [Organiser]; // convert to array
                for org in orgs {
                    PickManyData.append(infoType(title: org.name!, sub: org.role!, picked: false));
                }
                if !paramID.isEmpty {
                    // switch on if already added in organisers list.
                    let myEvent = events[editEventIndex];
                    let orgs = myEvent.organiserBy?.allObjects as! [Organiser];
                    for i in orgs {
                        for f in 0..<PickManyData.count  {
                            if PickManyData[f].title == i.name { PickManyData[f].picked = true; }
                        }
                    }
                }
            case editType.participant:
                
                do {
                    participants = try context.fetch(Participant.fetchRequest()); // refesh cat
                }
                catch {
                    print("Fetching Failed")
                }
                let pars = participants as [Participant]; // convert to array
                for par in pars {
                    PickManyData.append(infoType(title: par.name!, sub: par.role!, picked: false));
                }
                if !paramID.isEmpty {
                    // switch on if already added in participate list.
                    let myEvent = events[editEventIndex];
                    let pars = myEvent.paticipateBy?.allObjects as! [Participant];
                    for i in pars {
                        for f in 0..<PickManyData.count  {
                            if PickManyData[f].title == i.name { PickManyData[f].picked = true; }
                        }
                    }
                }
            default: return;
            }
        }

    func switchViewControllerPickMany(Name: String) {
        prepareDataPickMany();
        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Name) as! PickManyVC;
        nav.delegate = self;
        nav.paramData = PickManyData;
        navigationController?.pushViewController(nav, animated: true)
    }
}


extension EventItemTableVC: SearchChildDelegate{
    func returnData(_ data: cityInfo) {
        loc.text = data.name;
        navigationController?.popViewController(animated: true);
    }
 
    func switchViewControllersSearch(Name: String, thisData: [fcwtItem]) {
        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Name) as! SearchView
        nav.paramData = thisData
        nav.delegate = self;
        navigationController?.pushViewController(nav, animated: true)
    }
    
}
extension EventItemTableVC: DateTimePickerDelegate{
    func showDateTimePicker(sender: AnyObject) {
        let min = Date().addingTimeInterval(60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 7)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        
        // customize your picker
              picker.timeInterval = DateTimePicker.MinuteInterval.thirty
        //        picker.locale = Locale(identifier: "en_GB")
        //
         //       picker.todayButtonTitle = "Today"
        //        picker.is12HourFormat = true
        //        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        //        picker.isTimePickerOnly = true
        picker.includeMonth = true // if true the month shows at bottom of date cell
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "Done"
        picker.doneBackgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            print(formatter.string(from: date))
        }
        picker.delegate = self
        
        // add picker to your view
        // don't try to make customize width and height of the picker,
        // you'll end up with corrupted looking UI
        //        picker.frame = CGRect(x: 0, y: 100, width: picker.frame.size.width, height: picker.frame.size.height)
        // set a dismissHandler if necessary
        //        picker.dismissHandler = {
        //            picker.removeFromSuperview()
        //        }
        //        self.view.addSubview(picker)
        
        // or show it like a modal
        picker.show()
    }
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        print(picker.selectedDateString);
        dateTimeVal.text = picker.selectedDateString;
        
    }
    
    
}

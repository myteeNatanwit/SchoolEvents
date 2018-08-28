import Foundation
import CoreData
import UIKit

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
enum editType {
    case cat
    case participant
    case organiser
}
var editChoice : editType = editType.cat;

// used for city single pick
struct cityInfo {
    var id: String
    var name: String
    var lat: Float
    var long: Float
}

// used for multi pick
struct infoType {
    var title: String
    var sub: String
    var picked: Bool
}
var categories: [Category] = []
var events: [Event] = []
var organisers: [Organiser] = []
var payments: [Payment] = [];
var participants: [Participant] = [];
var schools: [School] = [];
var students: [Student] = [];

func getData() {
    do {
        categories = try context.fetch(Category.fetchRequest());
        organisers = try context.fetch(Organiser.fetchRequest());
        payments = try context.fetch(Payment.fetchRequest());
        participants = try context.fetch(Participant.fetchRequest());
        schools = try context.fetch(School.fetchRequest())
        students = try context.fetch(Student.fetchRequest())
        events = try context.fetch(Event.fetchRequest())
    }
    catch {
        print("Fetching Failed")
    }
}

func makeDummyData() {
/* old way
    //var entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
    //let newEvent = NSManagedObject(entity: entity!, insertInto: context)
    //    let newEvent2 = NSManagedObject(entity: entity!, insertInto: context)
    //    // add an event
    //    newEvent2.setValue("A dance in the moon", forKey: "desc");
    //    newEvent2.setValue("7 Ashburton drv, Mitcham, Vic 3132", forKey: "address")
    //    newEvent2.setValue(16, forKey: "fee");
    //    newEvent2.setValue("Harrison Ford", forKey: "organisers");
    //    newEvent2.setValue("Open", forKey: "status");
    //
 */
    let newEvent = Event(context: context);
    // add an event
    newEvent.id = "001";
    newEvent.desc = "A Walk in the Park";
    newEvent.address = "BoxHill";
    newEvent.fee = 12;
    newEvent.status = "Open";
    newEvent.distance = 14;
    newEvent.detail = "Nice walking in group in a warm day.";
    newEvent.dateTime = Calendar.current.date(byAdding: .day, value: 10, to: Date())! as NSDate;
    
    let newEvent2 = Event(context: context);
    newEvent2.id = "001";
    newEvent2.desc = "A Walk in the Cloud";
    newEvent2.address = "Mitcham";
    newEvent2.fee = 16;
    newEvent2.status = "Open";
    newEvent2.distance = 22;
    newEvent2.detail = "Light music, hot coffee, sundown time can be sweet."
    newEvent2.dateTime = Calendar.current.date(byAdding: .day, value: 7, to: Date())! as NSDate;
    
    // add 4 categories
    let newCatergory = Category(context: context);
    newCatergory.name = "Music";
    let newCatergory2 = Category(context: context);
    newCatergory2.name = "Sport";
    let newCatergory3 = Category(context: context);
    newCatergory3.name = "Seminar";
    let newCatergory4 = Category(context: context);
    newCatergory4.name = "Tour";
    
    // asign 1 cat to new event
    newEvent.category = newCatergory; // 1 to 1 relationship
    newEvent2.category = newCatergory2; // 1 to 1 relationship
    // add a few organisers
    let org1 = Organiser(context: context);
    org1.name = "John Smiths";
    org1.phone = "1111";
    org1.email = "abc1@aaa.com";
    org1.role = "Staff";
    let org2 = Organiser(context: context);
    org2.name = "Harison Ford";
    org2.phone = "222";
    org2.email = "abc2@aaa.com";
    org2.role = "Admin";
    let org3 = Organiser(context: context);
    org3.name = "Will Smith";
    org3.phone = "333";
    org3.email = "abc3@aaa.com";
    org3.role = "Head Dep";
    
    newEvent.addToOrganiserBy(org1); // 1 to many
    newEvent2.addToOrganiserBy(org2); // 1 to many
    newEvent2.addToOrganiserBy(org1); // 1 to many
    
    // add school
    let school = School(context: context);
    school.name = "Monash University";
    school.address = "clayton Campus";
    school.lat = -37.896751;
    school.lon = 145.147141;
    
    // add participant
    let newParticipant = Participant(context: context);
    newParticipant.name = "Kenu Reave";
    newParticipant.role = "Staff";
    let newParticipant2 = Participant(context: context);
    newParticipant2.name = "John Travota";
    newParticipant2.role = "Guess";
 
    newEvent.addToPaticipateBy(newParticipant);
    newEvent.addToPaticipateBy(newParticipant2);
    newEvent2.addToPaticipateBy(newParticipant);
    
    //add payment
    let newPayment = Payment(context: context);
    newPayment.amount = 12;
    newPayment.payFor = newEvent;
    newPayment.paidBy = newParticipant;
    newPayment.dateTime = Date() as NSDate;
    
    
    do {
        try context.save()
    } catch {
        print("Failed saving")
    }
    getData(); //  get data again
}


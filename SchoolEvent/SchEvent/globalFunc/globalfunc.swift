
import Foundation
import UIKit



/** Name: localStorageWrite
 for:  store data to local storage
 param:
 return:
 Note:
 Usage:
 */
func localStorageWrite(myKey: String, value: String) {
    let localStorage = UserDefaults.standard;
    localStorage.set(value, forKey : myKey);
}
/** Name: localStorageRead
 for: Get data from local storage
 param:
 return:
 Note:
 Usage:
 */

func localStorageRead(key: String) -> String{
    let localStorage = UserDefaults.standard;
    if let value: String = localStorage.object(forKey: key) as? String{
        return value;
    }
    return "";
}

func toDate(_ strDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm dd/MM/YYYY";
    let date = dateFormatter.date(from: strDate);
    return date!;
}

func alert (title: String, message: String) {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate;
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    alertController.addAction(alertAction)
    appDelegate.window!.rootViewController?.present(alertController, animated: true, completion: nil)
    
}

func msgBox (mytitle: String, mymessage: String, callback:  @escaping () -> ()) {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate;
    let refreshAlert = UIAlertController(title: mytitle, message: mymessage, preferredStyle: UIAlertControllerStyle.alert)
    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        callback()
    }))
    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        print("cancelled")
    }))
    appDelegate.window!.rootViewController?.present(refreshAlert, animated: true, completion: nil)
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
// usage: var color1 = hexStringToUIColor("#d3d3d3")
func hexStringToUIColor (hex: String) -> UIColor {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UIView{
    func showBlurLoader(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        
        self.addSubview(blurEffectView)
    }
    
    func removeBluerLoader(){
        self.subviews.flatMap {  $0 as? UIVisualEffectView }.forEach {
            $0.removeFromSuperview()
        }
    }
}
//today.toString(dateFormat: "dd-MM")
extension NSDate
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self as Date)
    }
    
}

// imageView.downloadedFrom(link: "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png")
extension UIImageView {
    func downloadedFrom(url: String) {
        let url = URL(string: url)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
    }
}


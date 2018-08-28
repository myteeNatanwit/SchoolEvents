
import UIKit
protocol AddSmthngDelegate {
    func childReturn(_ data: String)
}

class AddSmthng: UIViewController {

    var delegate: AddSmthngDelegate?
    
    @IBOutlet weak var txtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

  @IBAction func buttonTapped(_ sender: UIButton) {
    delegate?.childReturn(txtField.text!)
    
  }

}

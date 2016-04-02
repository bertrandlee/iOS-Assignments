
import UIKit

class ThirdViewController: UIViewController {
  /*
  TODO six: Hook up the number input text field, button and text label to this class. When the button is pressed, a message should be shown on the label indicating whether the number is even.
  
  */
    
    @IBOutlet weak var inputTextBox: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func onButtonPressed(sender: AnyObject)
    {
        let num:Int = Int(inputTextBox!.text!) ?? 0
        
        outputLabel.text = (num % 2 == 0) ? "is even" : "is not even"
    }
}

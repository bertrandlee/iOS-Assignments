
import UIKit

class SecondViewController: UIViewController {
  
  //TODO five: Display the cumulative sum of all numbers added every time the ‘add’ button is pressed. Hook up the label, text box and button to make this work.
    
    @IBOutlet weak var inputTextBox: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    var sum:Int = 0
    
    @IBAction func onButtonPressed(sender: AnyObject)
    {
        sum += Int(inputTextBox!.text!) ?? 0
        
        outputLabel.text = String(sum)
    }
}

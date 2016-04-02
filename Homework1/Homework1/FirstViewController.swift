
import UIKit

class FirstViewController: UIViewController {
    /*
     TODO one: hook up the #1 button in interface builder to a new action (to be written) in this class. Also hook up the label to this class. When the button is clicked, the function to be written must make a label say ‘hello world!’
     
     TODO two: Connect the ‘name’ and ‘age’ text boxes to this class. Hook up the #2 button to a NEW action. That function must look at the string entered in the text box and print out “Hello {name}, you are {age} years old!”
     TODO three: Hook up the #3 button to a NEW action. Print “You can drink” below the above text if the user is above 21. If they are above 18, print “you can vote”. If they are above 16, print “You can drive”
     TODO four: Hook up the #4 button to a NEW action. Print “you can drive” if the user is above 16 but below 18. It should print “You can drive and vote” if the user is above 18 but below 21. If the user is above 21, it should print “you can drive, vote and drink (but not at the same time!”.
     */
    
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var ageTextBox: UITextField!
    
    @IBAction func on1ButtonPressed(sender: AnyObject)
    {
        outputLabel.text = "hello world!"
    }
    
    
    @IBAction func on2ButtonPressed(sender: AnyObject)
    {
        printAge()
    }
    
    @IBAction func on3ButtonPressed(sender: AnyObject)
    {
        printAge()
        printRightsOnSeparateLines()
    }
    
    @IBAction func on4ButtonPressed(sender: AnyObject) {
        printAge()
        printRightsOnSameLine()
    }
    
    func printAge()
    {
        print(String(format: "Hello %@ you are %@ years old!",
                     nameTextBox!.text!,
                     ageTextBox!.text!))
    }
    
    func printRightsOnSeparateLines()
    {
        let age:Int = Int(ageTextBox!.text!) ?? 0
        
        if (age >= 21)
        {
            print("You can drink")
        }
        
        if (age >= 18)
        {
            print("You can vote")
        }
        
        if (age >= 16)
        {
            print("You can drive")
        }
    }
    
    func printRightsOnSameLine()
    {
        let age:Int = Int(ageTextBox!.text!) ?? 0
        
        if (age >= 21)
        {
            print("You can drive, vote and drink (but not at the same time!")
        }
        else if (age >= 18)
        {
            print("You can drive and vote")
        }
        else if (age >= 16)
        {
            print("You can drive")
        }
    }
    
    
}

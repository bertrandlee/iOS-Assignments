//
//  ViewController.swift
//  pass-by-ref-test
//
//  Created by Bertrand Lee on 7/4/16.
//  Copyright © 2016 Bertrand Lee. All rights reserved.
//

import UIKit

class TestClass
{
    var value:Int = 0
}

struct TestStruct
{
    var value:Int = 0
}

class ViewController: UIViewController {

    func modifyValues(myclass:TestClass, _ mystruct:TestStruct)
    {
        myclass.value = 4
        //mystruct.value = 5 // can't modify this because compiler says mystruct is a let constant
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myclass:TestClass = TestClass()
        let mystruct:TestStruct = TestStruct()
        
        // This prints "myclass = 0"
        print("myclass = " + String(myclass.value) + " mystruct = " + String(mystruct.value))
        
        modifyValues(myclass, mystruct)

        // This prints "myclass = 4"
        print("myclass = " + String(myclass.value) + " mystruct = " + String(mystruct.value))
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


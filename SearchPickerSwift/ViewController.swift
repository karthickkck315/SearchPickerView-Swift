//
//  ViewController.swift
//  SearchPickerSwift
//
//  Created by Apple on 29/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,pickerViewDelegate {

    @IBOutlet weak var textField: UITextField!
    var pickerData = ["Milk" , "Egg" , "Shop" , "Shopped","Shopping","Show","Water","tree","tea","coffee"]
    
    override func viewDidLoad() {
        textField.delegate = self
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showPicker()
    }
    func showPicker() {
        textField.resignFirstResponder()
        
       let myPickerView = MyPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), withNSArray:pickerData as NSArray )
        myPickerView.showPicker()
        //myPickerView.backgroundColor = .clear
        myPickerView.delegate = self
        self.view.addSubview(myPickerView)
        
//        textField.inputView = myPickerView
//        textField.inputView?.backgroundColor = .clear
    }
    func selectedRow(row: Int, text: String) {
        print(row)
        print(text)
        textField.text = text
    }

}


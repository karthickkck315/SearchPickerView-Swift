//
//  MyPickerView.swift
//  SearchPickerSwift
//
//  Created by Apple on 29/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

protocol pickerViewDelegate {
    
    //func finishPassing(string: String)
    func selectedRow(row: Int,text: String)
}

class MyPickerView: UIView,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UISearchBarDelegate {
    
    var arrRecords = NSArray()
    var searchArrRecords = NSMutableArray()
    var delegate: pickerViewDelegate?
    var picker = UIPickerView()
    var searchActive = Bool()
    
    init(frame: CGRect, withNSArray arrValues: NSArray) {
        super.init(frame: frame)
        arrRecords = arrValues
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showPicker() {
        searchActive = false
        
        picker = UIPickerView(frame: CGRect(x:0, y:self.frame.size.height-216, width:self.frame.size.width, height:216))
        picker.backgroundColor = .white
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        self.addSubview(picker)
        
        let toolBarView = UIView()
        toolBarView.frame = CGRect(x: 0, y: self.frame.size.height-256, width: self.frame.size.width, height: 50)
        toolBarView.isUserInteractionEnabled = true
        toolBarView.backgroundColor = UIColor.lightGray
        self.addSubview(toolBarView)
        
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 10, y: -2, width: self.frame.size.width-100, height: 30)
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.delegate = self
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        //searchBar.isTranslucent = false
        searchBar.backgroundColor = .clear
        toolBarView.addSubview(searchBar)
        
        let doneButton = UIButton()
        doneButton.frame = CGRect(x: self.frame.size.width-100, y: 10, width: 100, height: 30)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.addTarget(self, action: #selector(doneClick), for: .touchUpInside)
        toolBarView.addSubview(doneButton)
        
       /* let searchTextField = UITextField()
        searchTextField.frame = CGRect(x: 10, y: 7, width: self.frame.size.width-100, height: 30)
        searchTextField.delegate = self
        searchTextField.backgroundColor = UIColor.white
        searchTextField.layer.cornerRadius = 5
        searchTextField.clipsToBounds = true
        searchTextField.clearButtonMode = .whileEditing
        toolBarView.addSubview(searchTextField)*/
        
    }
    
    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if searchActive {
        return searchArrRecords.count
        } else {
        return arrRecords.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if searchActive {
        return searchArrRecords[row] as? String
        } else {
        return arrRecords[row] as? String
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if searchActive {
            print(searchArrRecords[row])
        } else {
            print(arrRecords[row])
        }
    }
    
    //MARK:- Search Bar
    let KEYBOARDAPPEAR = 226
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        GlobalClass.sharedInstance.animateViewMoving(up: true, moveValue: CGFloat(KEYBOARDAPPEAR), view: self)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        GlobalClass.sharedInstance.animateViewMoving(up: false, moveValue: CGFloat(KEYBOARDAPPEAR), view: self)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchArrRecords.removeAllObjects()
        if searchText.count > 0 {
            searchActive = true
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
            let array = (arrRecords as NSArray).filtered(using: searchPredicate)
            searchArrRecords = (array as NSArray).mutableCopy() as! NSMutableArray
            if searchArrRecords.count > 0 {
                picker.reloadAllComponents()
            }
        } else {
            searchActive = false
            picker.reloadAllComponents()
        }
        /* var ary_country:NSMutableArray = []
         print("Before ",ary_country) //"A", "E", "D", "B"
         let sorted = ary_country.sorted {($0 as AnyObject).localizedStandardCompare($1 as! String) == .orderedAscending}
         ary_country =  (sorted as NSArray).mutableCopy() as! NSMutableArray
         print("After", ary_country)*/
    }
    @objc func doneClick() {
        var selectedValue = String()
        if searchActive {
            if searchArrRecords.count > 0 {
                //selectedValue = searchArrRecords.object(at:0) as! String
                selectedValue = searchArrRecords.object(at: picker.selectedRow(inComponent: 0)) as! String
                let selectedRow = arrRecords.index(of:selectedValue)
                delegate?.selectedRow(row: selectedRow, text: selectedValue)
            }
        } else {
            selectedValue = arrRecords.object(at: picker.selectedRow(inComponent: 0)) as! String
            let selectedRow = arrRecords.index(of:selectedValue)
            delegate?.selectedRow(row: selectedRow, text: selectedValue)
        }
        self.removeFromSuperview()
    }
}

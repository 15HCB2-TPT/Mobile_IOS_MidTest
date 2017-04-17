//
//  Table_Add.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Table_Add_Edit: UIViewController/*, UIPickerViewDataSource, UIPickerViewDelegate, UIPassingProtocol*/ {
    
//    @IBOutlet weak var tfName: UITextField!
//    @IBOutlet weak var swSex: UISwitch!
//    @IBOutlet weak var imgSex: UIImageView!
//    @IBOutlet weak var dpBirthday: UIDatePicker!
//    @IBOutlet weak var pickerClasses: UIPickerView!
//    @IBOutlet weak var tvNotes: UITextView!
//    @IBOutlet weak var btnAddSave: UIBarButtonItem!
    
//    var updatedStudent: Student!
//    var funcAddSave: Bool = true
    
    //===== Storyboard Delegates =====
    override func viewDidLoad() {
        super.viewDidLoad()
        //seedClassrooms()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func uiPassedData(data: Any?){
//        if let st = data as! Student? {
//            tfName.text = st.name
//            swSex.isOn = st.sex
//            if swSex.isOn {
//                imgSex.image = UIImage(named: "Student Male-48.png")!
//            } else {
//                imgSex.image = UIImage(named: "Student Female-48.png")!
//            }
//            if let bd = st.bday {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "MM-dd-yyyy"
//                try dpBirthday.date = dateFormatter.date(from: bd)!
//            }
//            pickerClasses.selectRow(searchClassroom(name: (st.student_croom?.name)!), inComponent: 0, animated: true)
//            tvNotes.text = st.notes
//            //
//            btnAddSave.title = "Save"
//            funcAddSave = false
//            updatedStudent = st
//        }
//    }
//    
//    //===== PickerView =====
//    var classrooms: [Classroom]!
//    var selectedClassroom: Classroom!
//    
//    func searchClassroom(name: String) -> Int {
//        var index = 0
//        for each in classrooms {
//            if each.name == name {
//                return index
//            }
//            index = index + 1
//        }
//        return 0
//    }
//    
//    func seedClassrooms(){
//        if Database.isEmpty(entityName: "Classroom") {
//            Database.clear(entityName: "Classroom")
//            var seed = [Classroom]()
//            var tmp: Classroom
//            for i in 1...12 {
//                tmp = Database.create()
//                tmp.name = "\(i)"
//                seed.append(tmp)
//            }
//            Database.save()
//        }
//        let sorter = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
//        classrooms = Database.select(predicater: nil, sorter: [sorter])
//        selectedClassroom = classrooms.first
//        pickerClasses.selectRow(0, inComponent: 0, animated: true)
//    }
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return classrooms.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return classrooms[row].name
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedClassroom = classrooms[row]
//    }
//    
//    //===== Switch =====
//    @IBAction func swSex_ValueChanged(_ sender: Any) {
//        if swSex.isOn {
//            imgSex.image = UIImage(named: "Student Male-48.png")
//        } else {
//            imgSex.image = UIImage(named: "Student Female-48.png")
//        }
//    }
//    
//    //===== Button =====
//    @IBAction func btnAdd_Click(_ sender: Any) {
//        //prepare data
//        guard let name = tfName.text else {
//            return
//        }
//        if name == "" {
//            let alert = UIAlertController(title: "Alert", message: "Name field can not be empty!", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
//        let sex = swSex.isOn
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy"
//        let bday = dateFormatter.string(from: dpBirthday.date)
//        let croom = selectedClassroom
//        let notes = tvNotes.text
//        
//        //Add or Save
//        var st: Student
//        if funcAddSave {
//            st = Database.create()
//        } else {
//            st = updatedStudent
//        }
//        st.name = name
//        st.sex = sex
//        st.bday = bday
//        st.notes = notes
//        st.sortIndex = Int16(Database.count(entityName: "Student"))
//        st.student_croom = croom
//        Database.save()
//        
//        //alert
//        if funcAddSave {
//            let alert = UIAlertController(title: "Notify", message: "You added a new.", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        } else {
//            let alert = UIAlertController(title: "Notify", message: "The Student updated.", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
}


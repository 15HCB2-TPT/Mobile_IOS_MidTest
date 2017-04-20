//
//  AddFood_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Phạm Tú on 4/12/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class AddFood_ViewController: UIViewController {
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btnChooseImage: UIButton!
    @IBOutlet weak var txtNameFood: UITextField!
    @IBOutlet weak var txtStyleFood: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = false
        
        txtNameFood.inputAccessoryView = addDoneButton()
        txtStyleFood.inputAccessoryView = addDoneButton()
        txtPrice.inputAccessoryView = addDoneButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        scrollView.isScrollEnabled = true
        let info = notification.userInfo
        let keyboard = (info?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        
        let contentInset = UIEdgeInsetsMake(0, 0, keyboard.height, 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let info = notification.userInfo
        let keyboard = (info?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        
        let contentInset = UIEdgeInsetsMake(0, 0, -keyboard.height, 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        scrollView.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

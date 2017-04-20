//
//  AddNewRegion_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-Mac on 4/11/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class AddNewRegion_ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txt_nameregion: UITextField!
    @IBOutlet weak var txtview_des: UITextView!
    var imagePicker = UIImagePickerController()
    var customdelegate:RegionDelegate? = nil
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        if imageView.image != nil {
            let re: Region = Database.create()
            re.image = self.imageView.image?.pngRepresentationData
            if let name = txt_nameregion.text{
                re.name = name
            } else {re.name = ""}
            if let des = txtview_des.text {
                re.des = des
            } else {re.des = ""}
            Database.save()
            moveRegion()
        }
        else{
            let refreshAlert = UIAlertController(title: "Lỗi", message: "Bạn chưa chọn hình", preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnClicked() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewcontroller = segue.destination as! Region_ViewController
        viewcontroller.regions = Database.select(entityName: "Region") as! [Region]
        viewcontroller.collectionview.reloadData()
    }
    
    func moveRegion(){
        customdelegate?.reload()
        _ = navigationController?.popViewController(animated: true)
    }
}

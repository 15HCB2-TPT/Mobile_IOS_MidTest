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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

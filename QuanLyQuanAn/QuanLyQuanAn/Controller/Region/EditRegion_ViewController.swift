//
//  EditRegion_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-MacDesk on 4/11/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit


class EditRegion_ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    @IBOutlet weak var switch_isuse: UISwitch!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var txt_nameregion: UITextField!
    @IBOutlet weak var txtview_des: UITextView!
    var customdelegate:RegionDelegate? = nil
    var index = -1
    var imagePicker = UIImagePickerController()
    var rg:[Region] = Database.select(entityName: "Region") as! [Region]
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRegion()
    }
    
    //Load region
    func loadRegion(){
        image.image = UIImage(data: rg[index].image! as Data)
        if let name = rg[index].name{
            txt_nameregion.text = name
        } else{txt_nameregion.text = ""}
        if let des = rg[index].des{
            txtview_des.text = des
        } else{txt_nameregion.text = ""}
        if rg[index].is_deleted{
            switch_isuse.isOn=false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnChooseImageClicked(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func saveClick(_ sender: Any) {
        if let name = txt_nameregion.text{
            rg[index].name = name
        } else{rg[index].name = ""}
        if let des = txtview_des.text{
            rg[index].des = des
        } else{rg[index].des = ""}
        rg[index].image = image.image?.pngRepresentationData
        rg[index].is_deleted = !switch_isuse.isOn
        Database.save()
        moveRegion()
    }

    @IBAction func btnTrashClicked(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Xoá", message: "Chắc chắn xoá?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            Database.delete(object: self.rg[self.index])
            Database.save()
            self.moveRegion()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
            self.image.contentMode = .scaleAspectFit
            self.image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        })
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

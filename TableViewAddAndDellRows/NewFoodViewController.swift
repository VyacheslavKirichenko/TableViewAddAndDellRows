//
//  NewFoodViewController.swift
//  TableViewAddAndDellRows
//
//  Created by VyacheslavKrivoi on 5/4/19.
//  Copyright © 2019 VyacheslavKrivoi. All rights reserved.
//

import UIKit

class NewFoodViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageViewFood:UIImageView?
    @IBOutlet weak var txtFoodName:UITextField?
    @IBOutlet weak var lblRating:UILabel?
  
    var newFood = Food()
    @IBAction func btnSave(sender: UIButton){
        print("Press Save!")
        if (newFood.image == nil || newFood.rating ?? 0 < 1 || newFood.foodName?.count == 0) {
            let alertController = UIAlertController(title: "Alert", message: "Please set food's name, choose image, rating ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            //Add newFood to foods array
            foods.append(newFood)
            navigationController?.popViewController(animated: true)
            let mainViewController = self.navigationController?.topViewController as? MainViewController
            mainViewController?.tableView?.reloadData()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                //tap imageView
        let tapGestureToImageView = UITapGestureRecognizer(target: self, action: #selector(tapToImageView(sender:)))
        tapGestureToImageView.numberOfTapsRequired = 1
        imageViewFood?.isUserInteractionEnabled = true
        imageViewFood?.addGestureRecognizer(tapGestureToImageView)
        //
        let panGestureToLabelRating = UIPanGestureRecognizer(target: self, action: #selector(panInLabelRating(sender:)))
        lblRating?.isUserInteractionEnabled = true
        lblRating?.addGestureRecognizer(panGestureToLabelRating)
        
        let tapGestureToLabelRating = UITapGestureRecognizer(target: self, action: #selector(panInLabelRating(sender:)))
        tapGestureToLabelRating.numberOfTapsRequired = 1
        lblRating?.addGestureRecognizer(tapGestureToLabelRating)
        
    }
    @objc func tapToImageView(sender: UITapGestureRecognizer) {
        print("tap to imageView")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary;
        self.present(pickerController, animated: true, completion: nil)
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        imageViewFood!.image = image
        newFood.image = image
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let chosenImage:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
//        imageViewFood!.image = chosenImage
//        newFood.image = chosenImage
//        picker.dismiss(animated: true, completion: nil)
//    }
//
    
    @objc func panInLabelRating(sender: UIGestureRecognizer){
        let locationInView = sender.location(in: self.view) // position on label
        let newLabelRatingFrame = self.view.convert(lblRating!.frame, from: lblRating!.superview)
        
        let frame1 = CGRect(x: newLabelRatingFrame.origin.x, y: newLabelRatingFrame.origin.y,
                            width: newLabelRatingFrame.size.width/5, height: newLabelRatingFrame.size.height)
        let frame2 = CGRect(x: newLabelRatingFrame.origin.x, y: newLabelRatingFrame.origin.y,
                            width: 2*newLabelRatingFrame.size.width/5, height: newLabelRatingFrame.size.height)
        let frame3 = CGRect(x: newLabelRatingFrame.origin.x, y: newLabelRatingFrame.origin.y,
                            width: 3*newLabelRatingFrame.size.width/5, height: newLabelRatingFrame.size.height)
        let frame4 = CGRect(x: newLabelRatingFrame.origin.x, y: newLabelRatingFrame.origin.y,
                            width: 4*newLabelRatingFrame.size.width/5, height: newLabelRatingFrame.size.height)
        let frame5 = newLabelRatingFrame
        
        if (frame1.contains(locationInView)){
            lblRating?.text = "★☆☆☆☆"
            newFood.rating = 1
        } else if (frame2.contains(locationInView)){
            lblRating?.text = "★★☆☆☆"
            newFood.rating = 2
        } else if (frame3.contains(locationInView)){
            lblRating?.text = "★★★☆☆"
            newFood.rating = 3
        } else if (frame4.contains(locationInView)){
            lblRating?.text = "★★★★☆"
            newFood.rating = 4
        } else if (frame5.contains(locationInView)){
            lblRating?.text = "★★★★★"
            newFood.rating = 5
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print ("return true")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newFood.foodName = textField.text ?? ""
        textField.resignFirstResponder()
    }
    
    
    
}

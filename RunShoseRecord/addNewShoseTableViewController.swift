//
//  addNewShoseTableViewController.swift
//  RunShoseRecord
//
//  Created by lauda on 16/8/23.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit
import CoreData

class addNewShoseTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //定义鞋子变量
    var runShoseRecordAdd : RunShoseRecord!
    //定义是否喜欢鞋子
    var isLikeShose = false
    
    
    //定义时间格式
    let dateFormatter = NSDateFormatter()
    //实例时间选择器
    let datePicker = UIDatePicker()

    @IBOutlet weak var shoseNameTF: UITextField!
    @IBOutlet weak var shoseBrandTF: UITextField!
    @IBOutlet weak var shosePriceTF: UITextField!
    @IBOutlet weak var shoseBuyTimeTF: UITextField!
    @IBOutlet weak var shoseTypeTF: UITextField!
    @IBOutlet weak var shoseProfileTF: UITextField!
    @IBOutlet weak var shoseBuyURLTF: UITextField!
    @IBOutlet weak var shoseUseTimeTF: UITextField!
    @IBOutlet weak var shoseCommentTF: UITextField!
    @IBOutlet weak var shoseLocationTF: UITextField!
    
    @IBOutlet weak var shoseFavLabel: UILabel!
    
    @IBOutlet weak var shoseBuyTimeLABEL: UILabel!
    
    @IBAction func shoseFavBtn(sender: UIButton) {
        
        if sender.tag == 8001{
            
            isLikeShose = true
            shoseFavLabel.text = "我喜欢"
            
        } else if sender.tag == 8002 {
            
            isLikeShose = false
            shoseFavLabel.text = "我不喜欢"
        }
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    //保存新增加的鞋子信息的按钮
    @IBAction func saveBtn(sender: UIBarButtonItem) {
        
        //判断输入内容是否为空的方法
        panduanInput()
        
        //存储鞋子的数据到coredata
        
        //1、获取appdelegate中的托管对象缓冲区对象。UIApplication.sharedApplication().delegate as! AppDelegate
        let buffer = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        //2、创建一个鞋子信息实体对应的托管对象。调用类方法NSEntityDescription.insertNewObjectForEntityForName
        let runShoseDescription = NSEntityDescription.insertNewObjectForEntityForName("RunShoseRecord", inManagedObjectContext: buffer) as! RunShoseRecord
        
        runShoseDescription.shoseName = shoseNameTF.text!
        runShoseDescription.shoseBrand = shoseBrandTF.text
        runShoseDescription.shosePrice = shosePriceTF.text
        runShoseDescription.shoseBuyTime = shoseBuyTimeTF.text!
        runShoseDescription.shoseType = shoseTypeTF.text!
        runShoseDescription.shoseProfile = shoseProfileTF.text
        runShoseDescription.shoseBuyURL = shoseBuyURLTF.text
        runShoseDescription.shoseUseTime = shoseUseTimeTF.text
        runShoseDescription.shoseComment = shoseCommentTF.text
        runShoseDescription.shoseLocation = shoseLocationTF.text!
        
        if let image = imageView.image{
            runShoseDescription.shoseImage = UIImagePNGRepresentation(image)!
        }
        
//        runShoseDescription.shoseFav = shoseFav
        
        
        //3、让缓冲区保存托管对象到数据库，调用缓冲区的save方法
        do {
           try buffer.save()
        } catch {
            print(error)
            return
        }
        
        //4、点击保存按钮，退回到列表页
        performSegueWithIdentifier("unwindToHomeList", sender: sender)
        
        
    
    }
    
    //判断输入内容是否为空的方法
    func panduanInput() {
        if shoseNameTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseNameLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shoseBrandTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseBrandLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shosePriceTF.text == "" {
            
            let alertVC = UIAlertController(title: "shosePriceLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shoseBuyTimeTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseBuyTimeLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shoseTypeTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseTypeLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shoseProfileTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseProfileLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shoseBuyURLTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseBuyUrlLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shoseUseTimeTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseUseTimeLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shoseCommentTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseCommentLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        } else if shoseLocationTF.text == "" {
            
            let alertVC = UIAlertController(title: "shoseLocationLabel", message: "", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "是", style: .Default, handler: nil)
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //手写代码实现UIDatePicker控件和方法
        datePicker.hidden = true
        datePicker.frame = CGRectMake(0, 300, view.frame.width, 400)
        datePicker.datePickerMode = .Date
        datePicker.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(datePicker)
        datePicker.addTarget(self, action: #selector(addNewShoseTableViewController.pickerChangeDate), forControlEvents: .ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //行选择代码实现
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //判断第一行，实现相册获取照片功能
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            
        //判断第四行，实现时间选择器的功能
        } else if indexPath.row == 4 {
            //显示UIDatePicker
            datePicker.hidden = false
//            self.view.bringSubviewToFront(datePicker)
            
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //实现日期选择的方法
    func pickerChangeDate(datePicker:UIDatePicker) {
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
//        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        
        let datePC = dateFormatter.stringFromDate(datePicker.date)
        shoseBuyTimeLABEL.text = datePC
        
        shoseBuyTimeTF.text = shoseBuyTimeLABEL.text
        
        datePicker.hidden = true
        
    }
    
    //从相册 中获到图并显示在imageview的方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        //添加imageview上下左右相对于父容器边距为0的约束
        let leftCons = NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: imageView.superview, attribute: .Leading, multiplier: 1, constant: 0)
        let rightCons = NSLayoutConstraint(item: imageView, attribute: .Trailing, relatedBy: .Equal, toItem: imageView.superview, attribute: .Trailing, multiplier: 1, constant: 0)
        let topCons = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: imageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        let bottonCons = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        
        leftCons.active = true
        rightCons.active = true
        topCons.active = true
        bottonCons.active = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

       

        return cell
    }
    */
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

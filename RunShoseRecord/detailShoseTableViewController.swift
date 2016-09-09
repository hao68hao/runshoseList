//
//  detailShoseTableViewController.swift
//  RunShoseRecord
//
//  Created by lauda on 16/8/22.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class detailShoseTableViewController: UITableViewController {
    
    var detailShose : RunShoseRecord!

    @IBOutlet weak var detailshoesImage: UIImageView!
    
    @IBOutlet weak var favBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailshoesImage.image = UIImage(data: detailShose.shoseImage)
        
        //设置标题
        title = detailShose.shoseName
        
        //更改列表背景
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        
        //移除空行的分隔线及分割线颜色
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        //更改返回按钮样式
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        //设置单元格内容自适应
        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! detailShoseTableViewCell
        
        //单元格背景透明
        cell.backgroundColor = UIColor.clearColor()
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "鞋子名称"
            cell.valueLabel.text = detailShose.shoseName
        case 1:
            cell.fieldLabel.text = "鞋子品牌"
            cell.valueLabel.text = detailShose.shoseBrand
        case 2:
            cell.fieldLabel.text = "鞋子价格"
            cell.valueLabel.text = detailShose.shosePrice
        case 3:
            cell.fieldLabel.text = "购买时间"
            cell.valueLabel.text = detailShose.shoseBuyTime
        case 4:
            cell.fieldLabel.text = "使用状态"
            cell.valueLabel.text = detailShose.shoseType
        case 5:
            cell.fieldLabel.text = "鞋子简介"
            cell.valueLabel.text = detailShose.shoseProfile
        case 6:
            cell.fieldLabel.text = "购买地址"
            cell.valueLabel.text = detailShose.shoseBuyURL
        case 7:
            cell.fieldLabel.text = "使用时长"
            cell.valueLabel.text = detailShose.shoseUseTime
        case 8:
            cell.fieldLabel.text = "鞋子评价"
            cell.valueLabel.text = detailShose.shoseComment
        case 9:
            cell.fieldLabel.text = "地址显示"
            cell.valueLabel.text = detailShose.shoseLocation
//        case 10:
//            cell.fieldLabel.text = "是否喜欢"
//            cell.valueLabel.text = detailShose.shoseFav!.boolValue ? "喜欢" : "不喜欢"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        return cell
    }


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

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap"{
            let destVC = segue.destinationViewController as? mapViewController
            destVC?.mapShose = self.detailShose
        }
    }
  
    
    @IBAction func close(segue: UIStoryboardSegue){
        if let favVC = segue.sourceViewController as? FavViewController{
            if let pingjieBtn = favVC.favShose{
                self.detailShose.favShose! = pingjieBtn
                self.favBtn.setImage(UIImage(named: pingjieBtn), forState: .Normal)
                
                let buffer = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
                
                do {
                    try buffer.save()
                }catch{
                    print(error)
                }
            }
        }
    }
    

}

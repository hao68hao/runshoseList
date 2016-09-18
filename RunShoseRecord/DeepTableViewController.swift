//
//  DeepTableViewController.swift
//  RunShoseRecord
//
//  Created by lauda on 16/9/18.
//  Copyright © 2016年 lauda. All rights reserved.
//

//"https://zhuanlan.zhihu.com/p/21930884?refer=intelligentunit",
//"https://zhuanlan.zhihu.com/p/22232836?refer=intelligentunit",

import UIKit
import SafariServices

class DeepTableViewController: UITableViewController {
    
    var sectionDeepLearning = ["学习引导","第一学时","第二学时","第三学时"]
    var catalogDeepLearningTittle = [["贺完结！CS231n官方笔记授权翻译总集篇发布","知行合一码作业，深度学习真入门 "],
                                    ["CS231n课程笔记翻译：Python Numpy教程","CS231n课程笔记翻译：图像分类笔记（上）","CS231n课程笔记翻译：图像分类笔记（下）","CS231n课程笔记翻译：线性分类笔记（上）","CS231n课程笔记翻译：线性分类笔记（中）","CS231n课程笔记翻译：线性分类笔记（下）","CS231n课程笔记翻译：最优化笔记（上）","CS231n课程笔记翻译：最优化笔记（下）","CS231n课程笔记翻译：反向传播笔记","CS231n课程作业# 1简介"],
                                    ["CS231n课程笔记翻译：神经网络笔记1（上）","CS231n课程笔记翻译：神经网络笔记1（下）","CS231n课程笔记翻译：神经网络笔记 2 ","CS231n课程笔记翻译：神经网络笔记3（上）","CS231n课程笔记翻译：神经网络笔记3（下）","CS231n课程作业# 2简介"],
                                    ["CS231n课程笔记翻译：卷积神经网络笔记","CS231n课程作业# 3简介"]]
    
    
    var 第一学时URL = ["https://zhuanlan.zhihu.com/p/20878530?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/20894041?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/20900216?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/20918580?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/20945670?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/21102293?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/21360434?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/21387326?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/21407711?refer=intelligentunit",
                                  "https://zhuanlan.zhihu.com/p/21441838?refer=intelligentunit"]
    
    var 第二学时URL = ["https://zhuanlan.zhihu.com/p/21462488?refer=intelligentunit",
                           "https://zhuanlan.zhihu.com/p/21513367?refer=intelligentunit",
                           "https://zhuanlan.zhihu.com/p/21560667?refer=intelligentunit",
                           "https://zhuanlan.zhihu.com/p/21741716?refer=intelligentunit",
                           "https://zhuanlan.zhihu.com/p/21798784?refer=intelligentunit",
                           "https://zhuanlan.zhihu.com/p/21941485?refer=intelligentunit"]
    
    var 第三学时URL = ["https://zhuanlan.zhihu.com/p/22038289?refer=intelligentunit",
                           "https://zhuanlan.zhihu.com/p/21946525?refer=intelligentunit"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        } else if section == 1 {
            return 10
        } else if section == 2 {
            return 6
        } else {
            return 2
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionDeepLearning[section]
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deepCell", forIndexPath: indexPath)

        cell.textLabel?.text = catalogDeepLearningTittle[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let url1 = NSURL(string: "https://zhuanlan.zhihu.com/p/21930884?refer=intelligentunit")
                UIApplication.sharedApplication().openURL(url1!)
            } else {
                let url2 = NSURL (string: "https://zhuanlan.zhihu.com/p/22232836?refer=intelligentunit")
                UIApplication.sharedApplication().openURL(url2!)
            }
        case 1:

            if let url = NSURL(string: 第一学时URL[indexPath.row]){
                let sfVC = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                presentViewController(sfVC, animated: true, completion: nil)
            }
            
        case 2:
            
            if let url = NSURL(string: 第二学时URL[indexPath.row]){
                let sfVC = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                presentViewController(sfVC, animated: true, completion: nil)
            }
            
        case 3:
            
            if let url = NSURL(string: 第三学时URL[indexPath.row]){
                let sfVC = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                presentViewController(sfVC, animated: true, completion: nil)
            }

        default:
            break
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

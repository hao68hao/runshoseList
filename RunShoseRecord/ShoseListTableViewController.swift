//
//  ShoseListTableViewController.swift
//  RunShoseRecord
//
//  Created by lauda on 16/8/22.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit
import CoreData

class ShoseListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var shoseArray:[RunShoseRecord] = []
    
    var frc : NSFetchedResultsController!
    
    //定义搜索结果数据
    var srArray:[RunShoseRecord] = []
    
    //定义一个searchbarcontroller变量
    var sc: UISearchController!
    
    
    //筛选结果方法,返回包含搜索结果字符串的所有数据
    //swift中数组自带了filter方法，参数是一个闭包，筛选符合条件的元素，组成一个新数组返回
    //containsString检测一个字体串是否包含另一个字符串
    func searchFilter(textSearch:String) {
        srArray = shoseArray.filter({ (r) -> Bool in
            return r.shosePrice!.containsString(textSearch)
        })
    }
    
    //实现UISearchResultsUpdating协议中的updateSearchResultsForSearchController方法，将搜索结果展示在搜索控制器中。
    //将搜索条中输入的文字，赋给searchFilter方法
    func updateSearchResultsForSearchController(searchController: UISearchController){
        if var textToSearch = sc.searchBar.text{
            //去掉搜索字符中的空格
            textToSearch = textToSearch.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            searchFilter(textToSearch)
            tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1、使用NSFetchRequest,获取到存储在coredata中的数据表的名称
        let request = NSFetchRequest(entityName: "RunShoseRecord")
        
        //2、定义列表的排序规则，按鞋子名称
        let sd = NSSortDescriptor(key: "shoseName", ascending: true)
        
        //3、取回的数据按鞋子名称排序
        request.sortDescriptors = [sd]
        
        //4、获取appdelegate中的托管对象缓冲区对象。
        let buffer = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        //5、实现方法NSFetchedResultsController，将数据加载到本地NSFetchedResultsController
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: buffer, sectionNameKeyPath: nil, cacheName: nil)
        
        //6、NSFetchedResultsController初始化，指定代理为自己
        frc.delegate = self
        
        //7、执行查询，把结果保存到数组中，如果没有数据打印错误
        do {
            try frc.performFetch()
            shoseArray = frc.fetchedObjects as! [RunShoseRecord]
        } catch {
            print(error)
        }
        
        //实例化搜索控制器，指定搜索结果展示的视图为空，表示搜索结果将在当前的视图展示；
        sc = UISearchController(searchResultsController: nil)
        //将搜索控制器添加到表格的表头部分
        tableView.tableHeaderView = sc.searchBar
        sc.searchResultsUpdater = self //搜索结果为当前控制器
        sc.dimsBackgroundDuringPresentation = false  //搜索时背景不变暗
        
        sc.searchBar.placeholder = "请输入鞋子名称"
        
        sc.searchBar.tintColor = UIColor.whiteColor()
//        sc.searchBar.barTintColor = UIColor.orangeColor()
        sc.searchBar.searchBarStyle = .Minimal
        

    }
    
    //当数据库内容发生变化时，NSFetchedResultsControllerDelegate协议的以下方法会被调用：
    //当控制器开始处理内容变化时
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    //当控制器已经处理完内容变更时
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    //内容发生变更时,进行表格的插入、删除、更新、移动处理
    //所谓的可选绑定即：变量是不确定有值的，则需要在使用时，进行判断
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _indexPath = indexPath {
                tableView.insertRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        default:
            tableView.reloadData()
        }
        
        shoseArray = controller.fetchedObjects as! [RunShoseRecord]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //判断，如果搜索条active状态为 true，则返回搜索结果的数量；
        //如果搜索条active状态为false，则返回正常的表格数量；
        if sc.active == true {
            return srArray.count
        } else {
            return shoseArray.count
        }
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shoseListCell", forIndexPath: indexPath) as! shoseListTableViewCell
        
        //判断，定义一个变理r，
        //如果sc.active为true,则使用srArray[indexPath.row]内容，
        //如果sc.active不为true，则使用shoseArray[indexPath.row]内容；
        let r = sc.active ? srArray[indexPath.row] : shoseArray[indexPath.row]
        
        cell.shoseName.text = r.shoseName
        cell.shoseImage.image = UIImage(data: r.shoseImage)
        
        //设置图片为圆形
        cell.shoseImage.layer.cornerRadius = 30
        cell.shoseImage.clipsToBounds = true
        
        cell.shoseBrand.text = r.shoseBrand
        cell.shosePrice.text = r.shosePrice
        
        if (r.shoseFav != nil) {
            cell.accessoryType = .DetailButton
        } else {
            cell.accessoryType = .None
        }

        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        //定义滑动按钮UITableViewRowAction-分享
        let 分享 = UITableViewRowAction(style: .Normal, title: "分享") { (action, indexPath) -> Void in
            let alertVC = UIAlertController(title: "分享到", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let alertQQ = UIAlertAction(title: "QQ", style: .Default, handler: nil)
            let alertWX = UIAlertAction(title: "Wechat", style: .Default, handler: nil)
            let alertWB = UIAlertAction(title: "weibo", style: .Default, handler: nil)
            
            let 是否喜欢 = UIAlertAction(title: "是否喜欢", style: .Default) { (_) -> Void in
                
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                cell?.accessoryType = UITableViewCellAccessoryType.DetailButton
                
                //            自定义accessoryView
                cell?.accessoryView = UIView(frame: CGRectMake(0, 0, 35, 35))
                //            cell?.accessoryView?.backgroundColor = UIColor.blueColor()
                
                let acViewText = UILabel(frame: CGRectMake(0, 0, (cell!.accessoryView?.bounds.size.width)!, 12))
                acViewText.text = self.shoseArray[indexPath.row].shoseBrand
                acViewText.textColor = UIColor.grayColor()
                acViewText.font = UIFont.boldSystemFontOfSize(10)
                acViewText.textAlignment = NSTextAlignment.Center
                
                let acViewImage = UIImageView(image:UIImage(named:"red-1"))
                acViewImage.frame = CGRectMake(12, 12, acViewImage.bounds.size.width,acViewImage.bounds.size.height)
                
                cell!.accessoryView?.addSubview(acViewText)
                cell!.accessoryView?.addSubview(acViewImage)
            }
 
            let alertCance = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            
            alertVC.addAction(alertQQ)
            alertVC.addAction(alertWB)
            alertVC.addAction(alertWX)
            alertVC.addAction(是否喜欢)
            alertVC.addAction(alertCance)
            
            self.presentViewController(alertVC, animated: true, completion: nil)
            
        }
        分享.backgroundColor = UIColor.brownColor()
        
        //定义滑动按钮UITableViewRowAction-删除
        let 删除 = UITableViewRowAction(style: .Normal, title: "删除") { (action, indexPath) -> Void in
            
            //删除coredata中数据
            //1、获取托管对象
            let buffer = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            
            //使用NSFetchedResultsController的
            let delShoseArray = self.frc.objectAtIndexPath(indexPath) as! RunShoseRecord
            
            //删除托管对象中的数据
            buffer.deleteObject(delShoseArray)
            
            //保存数据
            do {
                try buffer.save()
            } catch {
                print(error)
            }
            
            
            
        }
        删除.backgroundColor = UIColor(red: 92/255, green: 177/255, blue: 65/255, alpha: 1)

        return [分享, 删除]
    }
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showShoseDetail" {
            let destVC = segue.destinationViewController as! detailShoseTableViewController
            
            //用户点击搜索结果单元格时，转场到搜索结果的详情页。
            destVC.detailShose = sc.active ? srArray[(tableView.indexPathForSelectedRow!.row)] : shoseArray[(tableView.indexPathForSelectedRow!.row)]
            
            destVC.hidesBottomBarWhenPushed = true
        }
    }
   
    //搜索单元格时不可编辑
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return !sc.active
    }
    
    
    /*
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     let 选项菜单 = UIAlertController(title: "选项菜单", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
     
     let 鞋名字提示 = UIAlertAction(title: "\(shoseName[indexPath.row])", style: .Default, handler: nil)
     
     
     //添加点击提示菜单，弹出提示对话框的形为
     let alertXingWei = {(action:UIAlertAction!) -> Void in
     let alertTiShiVC = UIAlertController(title: "品牌\(self.shoseBrand[indexPath.row])", message: "鞋子价格", preferredStyle: .Alert)
     let messAlert = UIAlertAction(title: "\(self.shosePrice[indexPath.row])", style: .Default, handler: nil)
     alertTiShiVC.addAction(messAlert)
     self.presentViewController(alertTiShiVC, animated: true, completion: nil)
     
     }
     
     let 鞋价格提示 = UIAlertAction(title: "这双鞋子价格？", style: .Default, handler: alertXingWei)
     
     let 是否喜欢 = UIAlertAction(title: "是否喜欢", style: .Default) { (_) -> Void in
     
     let cell = tableView.cellForRowAtIndexPath(indexPath)
     cell?.accessoryType = UITableViewCellAccessoryType.DetailButton
     /*
     //            自定义accessoryView
     cell?.accessoryView = UIView(frame: CGRectMake(0, 0, 35, 35))
     //            cell?.accessoryView?.backgroundColor = UIColor.blueColor()
     
     let acViewText = UILabel(frame: CGRectMake(0, 0, (cell!.accessoryView?.bounds.size.width)!, 12))
     acViewText.text = self.shoseBrand[indexPath.row]
     acViewText.textColor = UIColor.grayColor()
     acViewText.font = UIFont.boldSystemFontOfSize(10)
     acViewText.textAlignment = NSTextAlignment.Center
     
     let acViewImage = UIImageView(image:UIImage(named:"red-1"))
     acViewImage.frame = CGRectMake(12, 12, acViewImage.bounds.size.width,acViewImage.bounds.size.height)
     
     cell!.accessoryView?.addSubview(acViewText)
     cell!.accessoryView?.addSubview(acViewImage)
     */
     
     self.shoseFav[indexPath.row] = true
     
     }
     
     选项菜单.addAction(鞋名字提示)
     选项菜单.addAction(鞋价格提示)
     选项菜单.addAction(是否喜欢)
     self.presentViewController(选项菜单, animated: true, completion: nil)
     
     }
     */
    
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
     
            self.shoseName.removeAtIndex(indexPath.row)
            self.shoseImage.removeAtIndex(indexPath.row)
            self.shoseBrand.removeAtIndex(indexPath.row)
            self.shosePrice.removeAtIndex(indexPath.row)
            self.shoseFav.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
    }

    

}


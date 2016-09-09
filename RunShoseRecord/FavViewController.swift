//
//  FavViewController.swift
//  RunShoseRecord
//
//  Created by lauda on 16/8/23.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class FavViewController: UIViewController {
    
    var favShose : String?

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var favStackView: UIStackView!

    @IBAction func favBtnTapped(sender: UIButton) {
        switch sender.tag {
        case 100: favShose = "yellow-1"
        case 200: favShose = "black-1"
        case 300: favShose = "red-1"
        default:break
        }
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置背景图片的虚化
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        blurEffectView.frame = view.frame
        bgImageView.addSubview(blurEffectView)
        
        //设置favStackView的初始位置，现在设置为0，即不可见
//        favStackView.transform = CGAffineTransformMakeScale(0, 0)
        favStackView.transform = CGAffineTransformMakeTranslation(0, 500)
    }
    
    //当视图每一次显示完毕时候，即显示动画
    override func viewDidAppear(animated: Bool) {
        
        
        //普通动画-动画时长为0.3秒，内容是从0尺寸到原始大小
//        UIView.animateWithDuration(0.3, animations: {
//            self.favStackView.transform = CGAffineTransformIdentity
//            }, completion: nil)
        
        //高级动画-到达尾帧之前的震荡摆动效果
         UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.favStackView.transform = CGAffineTransformIdentity
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

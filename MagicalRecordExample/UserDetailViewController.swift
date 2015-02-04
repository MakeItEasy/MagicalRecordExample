//
//  UserDetailViewController.swift
//  MagicalRecordExample
//
//  Created by moyan on 15-2-4.
//  Copyright (c) 2015年 moyan. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var dpBirth: UIDatePicker!
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as UIBarButtonItem == self.btnSave {
            if self.user != nil {
                // 修改数据
                self.user!.name = self.txtUsername.text
                self.user!.age = self.txtAge.text.toInt()
                self.user!.birthday = self.dpBirth.date
            } else {
                // 添加数据
                /*
                // 如果使用这里的代码，那么马上就会提交到数据库，而且block应该是异步执行的
                MagicalRecord.saveWithBlock({(context: NSManagedObjectContext!) in
                    let user : User = User.MR_createInContext(context) as User
                    user.name = self.txtUsername.text
                    user.age = self.txtAge.text.toInt()
                    user.birthday = self.dpBirth.date
                })
                */
                // 使用下面这种方式，只是把数据保存在了Context中，并没有立即反应到数据库中。
                // 只有自己调用了 NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                // 才会保存数据到数据库
                let newUser = User.MR_createEntity() as User
                newUser.name = self.txtUsername.text
                newUser.age = self.txtAge.text.toInt()
                newUser.birthday = self.dpBirth.date
            }
        }
    }
    
    func initData() {
        if self.user != nil {
            self.txtUsername.text = self.user!.name
            self.txtAge.text = self.user!.age.description
            self.dpBirth.date = self.user!.birthday
        }
    }
}

//
//  TodoItemViewController.swift
//  TodoApp
//
//  Created by MikamiHiroyoshi on 2016/05/20.
//  Copyright © 2016年 MikamiHiroyoshi. All rights reserved.
//

import UIKit
import CoreData

class TodoItemViewController: UIViewController {

    // テキスト入力のoutlet
    @IBOutlet weak var todoField: UITextField!
    // タスクの宣言
    var task: Todo? = nil // オプショナル型で宣言
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // taskのアンラップ
        if let taskTodo = task {
            // 値のセット
            todoField.text = taskTodo.item
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // cancelタップ時のアクション
    @IBAction func cancel(sender: UIBarButtonItem) {
        // 前の画面へ戻る
        navigationController!.popViewControllerAnimated(true)
    }
    
    // saveタップ時のアクション
    @IBAction func save(sender: UIBarButtonItem) {
        
        // taskが存在する場合は編集
        if task != nil {
            editTask()
        } else {
            // それ以外は新規作成
            createTask()
        }
        
        // 前の画面へ戻る
        navigationController!.popViewControllerAnimated(true)
    }
    
    // 新規作成時の処理
    func createTask() {
        // タスクの作成
        let newTask: Todo = Todo.MR_createEntity()! as Todo
        // textFieldの文字入力を設定
        newTask.item = todoField.text!
        // タスクの保存
        newTask.managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }
    
    // 編集の処理
    func editTask() {
        task?.item = todoField.text!
        task?.managedObjectContext!.MR_saveToPersistentStoreAndWait()
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

//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by MikamiHiroyoshi on 2016/05/20.
//  Copyright © 2016年 MikamiHiroyoshi. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // tableViewのoutlet
    @IBOutlet weak var tableView: UITableView!
    var todoEntities: [Todo]!
    
    // タスクを登録した後に呼び出す
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 全タスク取得
        todoEntities = Todo.MR_findAll() as? [Todo]
        tableView.reloadData()
    }
    
    // リスト一覧取得
    override func viewDidLoad() {
        super.viewDidLoad()
        // リスト全件取得
        todoEntities = Todo.MR_findAll() as? [Todo]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 行数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoEntities.count
    }
    
    // セルに表示する内容を設定してセルを返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoListItem")
        cell!.textLabel!.text = todoEntities[indexPath.row].item
        return cell!
    }

    // スワイプでタスク削除
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 削除の場合
        if editingStyle == .Delete {
            // 削除処理を行う
            todoEntities.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            // リストの再読み込み
            tableView.reloadData()
        }
    }
    
    // edit時の処理
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 画面遷移時editだったら
        if segue.identifier == "edit" {
            let todoController = segue.destinationViewController as! TodoItemViewController
            // タップされたものをセット
            let task = todoEntities[tableView.indexPathForSelectedRow!.row]
            todoController.task = task
        }
    }

    func controllerDidChangeContext(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }

}


//
//  ViewController.swift
//  TaskManager
//
//  Created by Ruslan Safargalin on 07.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tasks: [Task]
    var parentTaskId: Int
    let cellIdentifier = "Cell"
    
    init(tasks: [Task], parentTaskId: Int = -1) {
        self.tasks = tasks
        self.parentTaskId = parentTaskId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.tasks = TaskManager.main.tasks
        self.parentTaskId = -1
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItems = getBarButtons()
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        guard let task = tasks[indexPath.item] as? CompositeTask else {
            let task = tasks[indexPath.item]
            cell.textLabel?.text = task.name
            cell.detailTextLabel?.isHidden = true
            return cell
        }
        
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = "Количество подзадач: \(task.tasks.count)"
        cell.detailTextLabel?.isHidden = false
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item < tasks.count,
              let task = self.tasks[indexPath.item] as? CompositeTask else { return }
        let controller = TableViewController(tasks: task.tasks, parentTaskId: task.id)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func getBarButtons() -> [UIBarButtonItem] {
        var buttons: [UIBarButtonItem] = []
        buttons.append(UIBarButtonItem(image: UIImage.addCompositeTaskImage, style: .plain, target: self, action: #selector(addCompositeTask)))
        buttons.append(UIBarButtonItem(image: UIImage.addConcreteTaskImage, style: .plain, target: self, action: #selector(addConcreteTask)))
        return buttons
    }
    
    @objc private func addConcreteTask() {
        showAddTaskDialog(for: .concrete)
    }
    
    @objc private func addCompositeTask() {
        showAddTaskDialog(for: .composite)
    }
    
    private func showAddTaskDialog(for taskType: TaskManager.TaskTypes) {
        let alert = UIAlertController(title: "Add task", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input task name here..."
        })

        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] action in

            if let name = alert.textFields?.first?.text, !name.isEmpty {
                let task = TaskManager.main.createTask(taskType, name: name)
                self?.saveTask(task)
                self?.tasks.append(task)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }))

        self.present(alert, animated: true)
    }
    
    func saveTask(_ task: Task) {
        guard let compositeTask = TaskManager.main.tasks.first(where: { $0.id == self.parentTaskId }) as? CompositeTask
        else {
            TaskManager.main.tasks.append(task)
            return
        }
        compositeTask.tasks.append(task)
    }
}


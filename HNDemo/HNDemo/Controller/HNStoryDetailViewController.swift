//
//  HNStoryDetailViewController.swift
//  HNDemo
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 inRoom. All rights reserved.
//

import UIKit
import WebKit

class HNStoryDetailViewController: UIViewController {

    var story : HNStoryDetail?
    @IBOutlet weak var storyID: UILabel!
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var sourceURL: UILabel!

    @IBOutlet weak var holder: UIView!
    @IBOutlet weak var stepper: UISegmentedControl!
    @IBOutlet weak var list: UITableView!
    
    var webview : WKWebView?
    
    var index : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Story Detail"
        self.navigationController?.navigationBar.tintColor = .white
        let wb = WKWebView(frame: list.frame)
        wb.load(URLRequest.init(url: URL(string: story?.url ?? "") ?? URL(fileURLWithPath: "https://")))
        webview = wb
        stepper.selectedSegmentIndex = index
        self.holder.card()
        self.storyID.text = String.init(format: "%d", story?.id ?? 0)
        self.storyTitle.text = String.init(format: "%@", story?.title ?? "")
        self.sourceURL.text = String.init(format: "%@", story?.url ?? "")
        self.list.tableFooterView = UIView()
    }
    
    @IBAction func valueChanges(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        self.list.reloadData()
        if sender.selectedSegmentIndex == 0 {
            self.list.backgroundView = self.webview
        } else {
            self.list.tableFooterView = UIView()
            self.list.backgroundView = nil
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("called")
    }
    
}

//MARK:- UItableViewDelegate & UItableViewDatasource
extension HNStoryDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if index == 0 {
            return 0
        }
        return self.story?.children?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let child = self.story?.children {
            return (child[section].children?.count ?? 0) + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HNStoryDetailCell.self), for: indexPath) as? HNStoryDetailCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.wrap(text: self.story?.children?[indexPath.section].attributedText, author: self.story?.children?[indexPath.section].author, time: self.story?.children?[indexPath.section].formattedTime)
            cell.const.constant = 8.0
        } else {
            cell.wrap(text: self.story?.children?[indexPath.section].children?[indexPath.row - 1].attributedText, author: self.story?.children?[indexPath.section].children?[indexPath.row - 1].author, time: self.story?.children?[indexPath.section].children?[indexPath.row - 1].formattedTime)
            cell.const.constant = 40.0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

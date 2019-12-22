//
//  HNTopStoriesViewController.swift
//  HNDemo
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 inRoom. All rights reserved.
//

import UIKit

class HNTopStoriesViewController: UIViewController, HNDelegate {
    
    var viewModel : HNStoryViewModel?
    
    @IBOutlet weak var storyList: UITableView!
    @IBOutlet weak var loadMore: UIButton!
    @IBOutlet weak var heightLoadMore: NSLayoutConstraint!
    @IBOutlet weak var widthLoadMore: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadMore.isHidden = true
        
        self.loadMore.layer.masksToBounds = true
        self.loadMore.layer.cornerRadius  = 25.0
        
        self.viewModel = HNStoryViewModel(self)
        self.viewModel?.fetchStories()
        self.storyList.tableFooterView = UIView()
    }

    func refreshScreenData() {
        DispatchQueue.main.async { [weak self] in
            self?.loadMore.isHidden = true
            self?.storyList.reloadData()
        }
    }
    
    @IBAction func loadMoreAction(_ sender: UIButton) {
        self.loadMore.isHidden = true
        self.viewModel?.fetchMore()
    }
    
}

//MARK:- UITableViewDelegate & UITableViewDataSource
extension HNTopStoriesViewController : UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: HNTopStoryCell.self), for: indexPath) as? HNTopStoryCell else { return UITableViewCell() }
        cell.wrap(story: self.viewModel?.getStoryDetails(index: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let details = self.viewModel?.getStoryDetails(index: indexPath.row) {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: HNStoryDetailViewController.self)) as? HNStoryDetailViewController else { return }
            controller.story = details
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height + 100 >= scrollView.contentSize.height {
            if self.viewModel?.storyDetails.count ?? 0 > 20 {
                self.loadMore.isHidden = false
            }
        } else {
            self.loadMore.isHidden = true
        }
    }
    
}

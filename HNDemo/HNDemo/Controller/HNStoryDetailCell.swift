//
//  HNStoryDetailCell.swift
//  HNDemo
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 HNDemo. All rights reserved.
//

import UIKit

class HNStoryDetailCell: UITableViewCell {

    @IBOutlet weak var const: NSLayoutConstraint!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var holder: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func add(view: UIView?) {
        self.holder.subviews.forEach({$0.removeFromSuperview()})
        if let v = view {
            v.frame = holder.frame
            holder.addSubview(v)
        }
    }
    
    func wrap(text: NSAttributedString?, author: String?, time: String?) {
        self.comment.attributedText = text
        self.author.text  = String.init(format: "Author : %@", author ?? "")
        self.time.text    = String.init(format: "Time : %@", time ?? "")
    }

}

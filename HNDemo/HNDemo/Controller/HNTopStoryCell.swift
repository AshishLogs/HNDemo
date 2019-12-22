//
//  HNTopStoryCell.swift
//  HNDemo
//
//  Created by MelpApp on 22/12/19.
//  Copyright © 2019 inRoom. All rights reserved.
//

import UIKit

class HNTopStoryCell: UITableViewCell {
    
    @IBOutlet weak var holder: UIView!
    @IBOutlet weak var storyid: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sourceURl: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var comments: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func wrap(story: HNStoryDetail?) {
        self.storyid.text = String.init(format: ": %d", story?.id ?? 0)
        self.points.text = String.init(format: ": %d points", story?.points ?? 0)
        self.title.text = String.init(format: ": %@", story?.title ?? "")
        self.sourceURl.text = String.init(format: ": %@", story?.url ?? "")
        self.time.text = String.init(format: ": %@", story?.formattedTime ?? "")
        self.authorName.text = String.init(format: ": %@", story?.author ?? "")
        self.comments.text = String.init(format: ": %d comments", story?.children?.count ?? 0)
        holder.card()
    }
    
    

}

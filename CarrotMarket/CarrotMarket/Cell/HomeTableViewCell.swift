//
//  MainTableViewCell.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/17.
//
// 기능 옮기기
import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemLocation: UILabel!
    @IBOutlet weak var itemWrittenTime: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemChat: UILabel!
    @IBOutlet weak var itemHeart: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func customizeCell(with item: ListedItem) {
        self.itemTitle.text = item.title
        self.itemLocation.text = item.location
        self.itemPrice.text = decimalWon(value: item.price)
        if let chat = item.chat {
            self.itemChat.text = "💬" + String(chat)
        } else {
            self.itemChat.text = ""
        }
        
        if let heart = item.heart {
            self.itemHeart.text = "🤍" + String(heart)
        } else {
            self.itemHeart.text = ""
        }
        
    }
    
    private func decimalWon(value: UInt) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
        
        return result
    }
    
    
}

//
//  TableHeaderView.swift
//  DoListApp
//
//  Created by YANA on 24/02/2022.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    static let identifier = "TableHeader"
    
    private let todayLable: UILabel = {
        let todayLable = UILabel()
        todayLable.text = "TODAY"
        todayLable.font = .boldSystemFont(ofSize: 30)
        todayLable.lineBreakMode = .byClipping
        return todayLable
    }()
    
    private let dateLable: UILabel = {
        let dateLable = UILabel()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        let today = Date()
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: today)
        let day = calendar.component(.day, from: today)
        dateLable.font = .systemFont(ofSize: 25)
        dateFormatter.locale = Locale(identifier: "eng")
        dateLable.text = String ("\(day) \(month)")
        dateLable.lineBreakMode = .byClipping
        return dateLable
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dateLable)
        contentView.addSubview(todayLable)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateLable.sizeToFit()
        dateLable.frame = CGRect(x: 10, y: todayLable.bottom + 10, width: contentView.frame.size.width-20, height: contentView.frame.size.height/3)
        todayLable.frame = CGRect(x: 10, y: 20, width: contentView.frame.size.width-20, height: contentView.frame.size.height/4)
    }
}

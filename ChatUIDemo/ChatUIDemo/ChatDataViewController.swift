//
//  ChatDataViewController.swift
//  Suho
//
//  Created by Shubham Vinod Kamdi on 30/04/20.
//  Copyright © 2020 Shubham Vinod Kamdi. All rights reserved.
//

import UIKit

class ChatDataViewController: UIViewController {
//FEEL FREE TO MODIFY THE VARIABLES AND UI OUTLETS
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var bottomConstriant: NSLayoutConstraint!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var profileNAme: UILabel!
    
    
    
    var timer: Timer!
    var name: String!
    var profI: UIImage!
    var id: [String] = []
    var isEditingText: Bool!
    var scrollForFirstTimeFlag: Bool = true
    var chatImg: UIImage!
    var fromChatListing: Bool = false
    var dataCount: Int = 0
    var dataReceivedSoFar: Int = 0
    var paginationCount: Int = 1
    var recievedData: Int = 0
    var firstTimeFLag: Bool = true
    var doNotAppendFlag: Bool!
    var chatID: String!
    var chatName: String!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTable.register(SenderChatTableViewCell.self, forCellReuseIdentifier: "Sender")
        chatTable.register(ReceiverChatTableViewCell.self, forCellReuseIdentifier: "Reciever")
        chatTable.delegate = self
        chatTable.dataSource = self
        //self.profileNAme.text = self.chatName
        //self.profileImage.image = self.chatImg
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updatePaginationCount), userInfo: nil, repeats: true)
    
    }
    
    func updateChatUI(){
        //UODATING THE CHAT UI
    }
    
    func sendMessageService(){
            //SENDING MESSAGES
    }
    
    func sendHi(){
            //AUTO MSG CODE SHOULD GO HERE
    }
    
    @objc func updatePaginationCount(){
         //CHECKING IN BACKGROUND FOR NEW MSG UPDATES
    }
    
    @IBAction func sendMessage(){
        sendMessageService()
    }
           
           @objc func keyBoardWillShow(notification: Notification){
               if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
                   let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
                   let keyBoardRect = frame?.cgRectValue
                   if let keyBoardHeight = keyBoardRect?.height {
                       self.bottomConstriant.constant = keyBoardHeight
                       
                       UIView.animate(withDuration: 0.5, animations: {
                           self.view.layoutIfNeeded()
                       })
                   }
               }
           }
           
           @objc func keyBoardWillHide(notification: Notification){
               
               self.bottomConstriant.constant = 10
               UIView.animate(withDuration: 0.5, animations: {
                   self.view.layoutIfNeeded()
               })
           }
    

    func deleteMsg(index: Int){
        //YOUR DELETE MSG CODE
    }

}


extension ChatDataViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //       let count = chatPageSG.count - 1
    //        return chatPageSG[count].chatSG.count
            return 20
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.row % 2 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Sender") as! SenderChatTableViewCell
            cell.senderLabelCustom.text = "SENDER_MESSAGE_\(indexPath.row)"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Reciever") as! ReceiverChatTableViewCell
            cell.receiverLabelCustom.text = "RECIEVER_MESSAGE_\(indexPath.row)"
            return cell
        }

        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    
   
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.deleteMsg(index: indexPath.row)
        }
    }

    
    
}

class SenderChatTableViewCell: UITableViewCell {

    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var senderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    let senderLabelCustom = UILabel()
    let bubbleBackgroundView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bubbleBackgroundView.backgroundColor = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
        bubbleBackgroundView.layer.cornerRadius = 5
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        addSubview(senderLabelCustom)
        senderLabelCustom.translatesAutoresizingMaskIntoConstraints = false
        senderLabelCustom.numberOfLines = 0
        senderLabelCustom.text = "Some text content finally cell is expanding Some text content finally cell is expanding Some text content finally cell is expanding Some text content finally cell is expanding"
        senderLabelCustom.textColor = .white
        //senderLabelCustom.backgroundColor = .white
        //senderLabelCustom.layer.cornerRadius = 15
        senderLabelCustom.translatesAutoresizingMaskIntoConstraints = false
        
        let customConstraint = [senderLabelCustom.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
                                senderLabelCustom.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
                                senderLabelCustom.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
                                senderLabelCustom.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
                                bubbleBackgroundView.topAnchor.constraint(equalTo: senderLabelCustom.topAnchor, constant: -16),
                                bubbleBackgroundView.leadingAnchor.constraint(equalTo: senderLabelCustom.leadingAnchor, constant: -16),
                                bubbleBackgroundView.bottomAnchor.constraint(equalTo: senderLabelCustom.bottomAnchor, constant: 16),
                                bubbleBackgroundView.trailingAnchor.constraint(equalTo: senderLabelCustom.trailingAnchor, constant: 16)]
        NSLayoutConstraint.activate(customConstraint)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}

class ReceiverChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var receriverView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    let receiverLabelCustom = UILabel()
    let bubbleBackgroundView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bubbleBackgroundView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        bubbleBackgroundView.layer.cornerRadius = 5
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        
        addSubview(receiverLabelCustom)
        receiverLabelCustom.textColor = .black
        receiverLabelCustom.translatesAutoresizingMaskIntoConstraints = false
        //receiverLabelCustom.backgroundColor = .white
        //receiverLabelCustom.layer.cornerRadius = 15
        receiverLabelCustom.numberOfLines = 0
        receiverLabelCustom.text = "SOME SOME SOME SOME SOME SOME SOME SOME SOME"
        let customConstraint = [receiverLabelCustom.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
        receiverLabelCustom.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
        receiverLabelCustom.widthAnchor.constraint(equalToConstant: 220),
        receiverLabelCustom.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
        bubbleBackgroundView.topAnchor.constraint(equalTo: receiverLabelCustom.topAnchor, constant: -16),
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: receiverLabelCustom.leadingAnchor, constant: -16),
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: receiverLabelCustom.bottomAnchor, constant: 16),
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: receiverLabelCustom.trailingAnchor, constant: 16)]
        NSLayoutConstraint.activate(customConstraint)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var CornerRadiusCard: CGFloat = 5
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.9
    
    override func layoutSubviews() {
        layer.cornerRadius = CornerRadiusCard
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: CornerRadiusCard)
        layer.masksToBounds = false
        //layer.borderColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0).cgColor
        //layer.borderWidth = 1
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}

//
//  CommentViewController.swift
//  Instagram
//
//  Created by 杉田優衣 on 2022/07/09.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var id = ""
    
    @IBOutlet weak var commentField: UITextField!
    @IBAction func handleCommentPostButton(_ sender: Any) {
        //投稿データの保存場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document(id)
        
        //HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        //FireStoreに投稿データを保存する
        let name = Auth.auth().currentUser!.displayName!
        let postDic = "\(String(describing: name)):\(self.commentField.text!)"
        let updateValue = FieldValue.arrayUnion([postDic])
        
        postRef.updateData(["comment": updateValue])
        
        //HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        
        //投稿処理が完了したので先頭画面に戻る
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func handleCommentCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

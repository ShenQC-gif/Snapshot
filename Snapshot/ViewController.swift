//
//  ViewController.swift
//  Snapshot
//
//  Created by ちいつんしん on 2021/03/11.
//

import UIKit

class ViewController: UIViewController {

    //インスタンス作成
    private var snapshot = Snapshot()

    @IBAction func didTapTakButton(_ sender: Any) {

        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        //snapshotするサイズを規定
        let size = CGSize(width: width, height: height * 12 / 24)

        //snapshotした画像を載せたactivityVCを作成
        let activityVC = snapshot.share(size: size, view: view)

        //activityVCを表示
        present(activityVC, animated: true, completion: nil)
    }

}

class Snapshot {

    private var snapshotImage = UIImage()

    func take(size: CGSize, view: UIView) {

        //bitmapの描画環境を構築し、描画開始
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        //渡されたviewの切り出し
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)

        //切り出した部分をUIImageとして保存
        snapshotImage = UIGraphicsGetImageFromCurrentImageContext()!

        //描画終了
        UIGraphicsEndImageContext()
    }

    func share(size: CGSize,  view: UIView) -> UIActivityViewController {

        //描画してUIImageを切り出し
        take(size: size, view: view)


        //アクティビティビューに渡すために[Any]型に変換
        let items = [snapshotImage] as [Any]

        // アクティビティビューに載せる
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)

        return activityVC
    }
}


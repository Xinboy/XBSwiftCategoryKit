//
//  UIImageExtension.swift
//  Pods-XBSwiftCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/11/28.
//

import Foundation
import Photos

extension UIImage {
    
    
    
    private class func configureAsset(_ asset: PHAsset, completion: @escaping((URL?) -> ())) {
        /*
             1、将PHAsset生成PHAssetResource
             2、遍历resource，然后下载，这里我用的是PHAssetResourceManager，网上还有别的方法，多得是。
             3、这个可以用输出流，不耗内存，多张图片放内存不合适。应该写入文件，通过路径访问；操作完成后，记得把缓存删掉
             PS：为什么用输出流呢，这样内存不需要缓存NSData二进制
         */
        let resource = PHAssetResource.assetResources(for: asset)
        resource.forEach({ (res) in
            let path = NSTemporaryDirectory() + res.originalFilename
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {}
            }
            
            // 创建输出流
            let stream = OutputStream.init(toFileAtPath: path, append: true)
            // 打开输出流
            stream?.open()
            
            //提示正在缓存
            print("正在缓存")
            
            let options = PHAssetResourceRequestOptions.init()
            options.isNetworkAccessAllowed = true
            options.progressHandler = { (progress) in
                DispatchQueue.main.async {
                    print(progress)
                }
            }
            PHAssetResourceManager.default().requestData(for: res, options: options, dataReceivedHandler: { (data) in
                var buffer = [UInt8].init(repeating: 0, count: data.count)
                data.copyBytes(to: &buffer, count: data.count)
                // 写入文件
                stream?.write(buffer, maxLength: buffer.count)
                
            }, completionHandler: { (error) in
                // 关闭输出流
                stream?.close()
                // 主线程回调
                DispatchQueue.main.async {
                    print("完成缓存")
                    if error == nil {
                        completion(URL.init(fileURLWithPath: path))
                    } else {
                        completion(nil)
                    }
                }
            })
            
        })
    }
}

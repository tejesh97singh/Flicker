//
//  GetImageList.swift
//  Flicker
//
//  Created by Tejesh Singh on 30/06/22.
//

import Foundation

protocol PhotoList {
    func didGetImages(imageUrl:[Photo])    
}
struct GetImageList{
    var delegate : PhotoList?
    func getImage(imageName: String){
        let urlString = Constants.searchURL  + "&text=\(imageName)"
        print(urlString)
        request(requestString: urlString)
        
    }
    func request(requestString:String){
       if let dataUrl = URL(string: requestString){
            
            let session = URLSession(configuration: .default)
            session.dataTask(with: dataUrl) { (data, response, error) in
                if error != nil{
                    // show error using alert or toast
                    print(error?.localizedDescription)
                }
                if response != nil{
                    // response in non nil
                }
                if let apiData = data{
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(FlickerModel.self,from:apiData)
                        
                        let decodedImages = (decodedData.photos)?.photo
                        
                        if let imageArray = decodedImages{
                            delegate?.didGetImages(imageUrl: imageArray)
                           // print(imageArray)
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                print(apiData)}
            }.resume()
            
        }
    }

}


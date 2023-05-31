import Foundation

class NetworkManager {
    
    func getData(from url: URL, completion: @escaping (Int?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            completion(httpResponse.statusCode, error)
        }
        task.resume()
    }
    
}

import Foundation

class ApiProvider {
    
    init(baseUrl: URL = URL(string: "https://stoplight.io/mocks/")!) {
        self.baseUrl = baseUrl
    }
    
    private let baseUrl: URL
    @discardableResult func getData<Response: Codable>(
        _ model: Response.Type = Response.self,
        from endpoint: String,
        _ completion: @escaping (Result<Response, Error>) -> Void
    ) -> URLSessionDataTask {
        let url = baseUrl.appendingPathComponent(endpoint)
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Ошибка получения данных")
                DispatchQueue.main.async {
                    if let error = error {
                    completion(.failure(error))
                    } else {
                        print("неизвестная ошибка")
                    }
                }
             return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let result = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    print("Не получается сконвертировать JSON: \(error)")
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
        return dataTask
    }
}

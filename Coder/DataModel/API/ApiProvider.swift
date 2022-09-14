import Foundation

final class ApiProvider {
    
    private let baseUrl: URL
    
    init(baseUrl: URL = URL(string: "https://stoplight.io/mocks/")!) {
        self.baseUrl = baseUrl
    }
    
    @discardableResult
    func getData<Response: Codable>(
        _ model: Response.Type = Response.self,
        from endpoint: String,
        _ completion: @escaping (Result<Response, Error>) -> Void
    ) -> URLSessionDataTask {
        let url = baseUrl.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.addValue("dynamic=true", forHTTPHeaderField: "Prefer")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
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

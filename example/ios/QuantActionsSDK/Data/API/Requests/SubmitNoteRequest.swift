import Foundation

struct SubmitNoteRequest: URLRequestBuilder {
    let deviceID: String
    let body: NoteDTO

    func build() throws -> URLRequest {
        var request = try URLRequest(string: "\(Config.baseServerURL)/TapDevices/\(deviceID)/submitNote")
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try JSONEncoder().encode(body)
        request.add(header: HTTPHeader.contentType(.json))

        return request
    }
}

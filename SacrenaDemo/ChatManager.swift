//
//  ChatManager.swift
//  SacrenaDemo
//
//  Created by Labhesh Dudi on 13/09/24.
//

import Foundation
import StreamChat
import StreamChatUI

final class ChatManager {
    static let shared = ChatManager()
    
    private var client: ChatClient!
    
    let accessTokenAlice = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYWxpY2UifQ.02F2-8sObKAJAs3550YUCy4JCP9sM9oHD1LHOYFfySc"
    let accessTokenBob = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYm9iIn0.EUPUUnyvg3oU-x-20-MT0C4Xxfdiq38QdRwVT5Cus2w"
    
    func setup() {
        let client = ChatClient(config: .init(apiKey: .init("d4v7mteappvt")))
        self.client = client
    }
    
    func signIn(completion: @escaping (Bool) -> Void) {
        client.connectUser(userInfo: UserInfo(id: "alice", name: "alice"), token: Token(stringLiteral: accessTokenAlice)) { error in
            completion(error == nil)
        }
    }
    
    func getChannelList() -> UIViewController? {
        guard let currentUserId = client.currentUserId else { return nil }
        let list = client.channelListController(query: .init(filter: .containMembers(userIds: [currentUserId])))
        
        let vc = ChatChannelListVC()
        vc.content = list
        list.synchronize { error in
            if let error = error {
                print(error)
            }
        }
        return vc
    }
    
    func createNewChannel(name: String){
        do {
            let result = try client.channelController(createChannelWithId: .init(type: .messaging, id: UUID().uuidString), name: name, members: ["alice", "bob"])
            result.synchronize()
        } catch {
            print("something went wrong")
        }
    }
}

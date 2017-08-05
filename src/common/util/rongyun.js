/**
 * 封装融云云服务操作
 * 初始化
 * 发送消息
 * 消息监听并实现添加到聊天记录中
 */

import App from '@/common/data/keys'
import Store from '@/store'
import types from '@/store/types'

export default {
  setListenAndconnectRongyun() {
    // 初始化
    // RongIMClient.init(appkey, [dataAccessProvider],[options])
    // appkey:官网注册的appkey。
    // dataAccessProvider:自定义本地存储方案的实例，不传默认为内存存储，自定义需要实现WebSQLDataProvider所有的方法，此参数必须是传入实例后的对象。
    RongIMClient.init(App.AppInfo.APPKEY)
    // 设置连接监听状态 （ status 标识当前连接状态）
    // 连接状态监听器
    RongIMClient.setConnectionStatusListener({
      onChanged: function (status) {
        switch (status) {
          //链接成功
          case RongIMLib.ConnectionStatus.CONNECTED:
            console.log('链接成功')
            break
          //正在链接
          case RongIMLib.ConnectionStatus.CONNECTING:
            console.log('正在链接')
            break
          //重新链接
          case RongIMLib.ConnectionStatus.DISCONNECTED:
            console.log('断开连接')
            break
          //其他设备登录
          case RongIMLib.ConnectionStatus.KICKED_OFFLINE_BY_OTHER_CLIENT:
            console.log('其他设备登录')
            break
          //网络不可用
          case RongIMLib.ConnectionStatus.NETWORK_UNAVAILABLE:
            console.log('网络不可用')
            break
        }
      }
    })
    // 消息监听器
    RongIMClient.setOnReceiveMessageListener({
      // 接收到的消息
      onReceived: function (message) {
        console.log('接收到消息')
        console.log(message)
        // 判断消息类型
        switch (message.messageType) {
          case RongIMClient.MessageType.TextMessage:
            //进行沉浸式状态栏通知
            
            Store.commit(types.ADD_CHAT_CHAT, {
              from: parseInt(message.senderUserId),
              to: parseInt(message.targetId),
              content: message.content.content,
              failed: false,
              unopen: true
            })
            break
          case RongIMClient.MessageType.VoiceMessage:
            // 对声音进行预加载                
            // message.content.content 格式为 AMR 格式的 base64 码
            RongIMLib.RongIMVoice.preLoaded(message.content.content)
            break
          case RongIMClient.MessageType.ImageMessage:
            // do something...
            break
          case RongIMClient.MessageType.DiscussionNotificationMessage:
            // do something...
            break
          case RongIMClient.MessageType.LocationMessage:
            // do something...
            break
          case RongIMClient.MessageType.RichContentMessage:
            // do something...
            break
          case RongIMClient.MessageType.DiscussionNotificationMessage:
            // do something...
            break
          case RongIMClient.MessageType.InformationNotificationMessage:
            // do something...
            break
          case RongIMClient.MessageType.ContactNotificationMessage:
            // do something...
            break
          case RongIMClient.MessageType.ProfileNotificationMessage:
            // do something...
            break
          case RongIMClient.MessageType.CommandNotificationMessage:
            // do something...
            break
          case RongIMClient.MessageType.CommandMessage:
            // do something...
            break
          case RongIMClient.MessageType.UnknownMessage:
            // do something...
            break
          default:
          // 自定义消息
          // do something...
        }
      }
    })
    // 连接融云服务器。
    RongIMClient.connect(App.AppInfo.RONGYUNTOKEN, {
      onSuccess: function (userId) {
        console.log("成功登录到融云云服务，用户id为:" + userId)
      },
      onTokenIncorrect: function () {
        console.log('token无效')
      },
      onError: function (errorCode) {
        var info = ''
        switch (errorCode) {
          case RongIMLib.ErrorCode.TIMEOUT:
            info = '超时'
            break
          case RongIMLib.ErrorCode.UNKNOWN_ERROR:
            info = '未知错误'
            break
          case RongIMLib.ErrorCode.UNACCEPTABLE_PaROTOCOL_VERSION:
            info = '不可接受的协议版本'
            break
          case RongIMLib.ErrorCode.IDENTIFIER_REJECTED:
            info = 'appkey不正确'
            break
          case RongIMLib.ErrorCode.SERVER_UNAVAILABLE:
            info = '服务器不可用'
            break
        }
        console.log(errorCode)
      }
    })
  },
  sendMessage(targetId, msg, id, extra) {
    // 参数分别是
    // 对方用户的id，类型为字符串
    // 发送的消息
    // 发送的消息的id
    // 发送的附加消息
    return new Promise((resolve, reject) => {
      let target = '' + targetId
      // 定义消息类型,文字消息使用 RongIMLib.TextMessage
      var msgObj = new RongIMLib.TextMessage({ content: msg, extra: extra || '无附加信息' })
      //或者使用RongIMLib.TextMessage.obtain 方法.具体使用请参见文档
      //var msg = RongIMLib.TextMessage.obtain("hello")
      var conversationtype = RongIMLib.ConversationType.PRIVATE // 私聊
      RongIMClient.getInstance().sendMessage(conversationtype, target, msgObj, {
        // 发送消息成功
        onSuccess: function (message) {
          console.log('消息发送成功')
          console.log(message)
          //message 为发送的消息对象并且包含服务器返回的消息唯一Id和发送消息时间戳
          Store.commit(types.UPDATE_CHAT_FAILED, { id: id, failed: false })
          resolve()
        },
        onError: function (errorCode, message) {
          Store.commit(types.UPDATE_CHAT_FAILED, {id: id, failed: true})
          let info = ''
          switch (errorCode) {
            case RongIMLib.ErrorCode.TIMEOUT:
              info = '网络超时'
              break
            case RongIMLib.ErrorCode.UNKNOWN_ERROR:
              info = '发生未知错误'
              break
            case RongIMLib.ErrorCode.REJECTED_BY_BLACKLIST:
              info = '在黑名单中，无法向对方发送消息'
              break
            case RongIMLib.ErrorCode.NOT_IN_DISCUSSION:
              info = '不在讨论组中'
              break
            case RongIMLib.ErrorCode.NOT_IN_GROUP:
              info = '不在群组中'
              break
            case RongIMLib.ErrorCode.NOT_IN_CHATROOM:
              info = '不在聊天室中'
              break
            default:
              info = '发送出错'
              break
          }
          reject(info)
        }
      })
    })
  },
  getMessage() {
    //此接口必须在init()方法之后，连接融云服务器 connect 之前调用。
    return new Promise((resolve, reject) => {
      RongIMClient.getInstance().hasRemoteUnreadMessages(App.AppInfo.RONGYUNTOKEN, {
        onSuccess: function (hasMessage) {
          if (hasMessage) {
            // 有未读的消息
            resolve(hasMessage)
          } else {
            // 没有未读的消息,返回false
            resolve(false)
          }
        },
        onError: function (err) {
          // 错误处理...
          reject('访问出错')
        }
      })
    })
  },
  disconnect() {
    RongIMClient.getInstance().disconnect()
  }
}
<template>
  <div class="chat-div">
    <div class="title">
	  	<span class="glyphicon glyphicon-menu-left" aria-hidden="true" @click="backward"></span >
	    <span class="center">{{chatfriend.friend_name}}</span>
	  </div>
    <div class="message-content">
      <chat-item v-for="chatmsg in getMessages" :chatmsg="chatmsg" :key="chatmsg.id"></chat-item>
    </div>
    <div class="text-div">
      <textarea class="text" contenteditable="true" v-model.lazy.trim="text"></textarea>
      <span class="button" @click="sendMessage">发送</span>
    </div>
  </div>
</template>

<style lang="css" scoped>
.chat-div {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100vh;
}

.message-content {
  flex: 1;
  padding: 5rem 0;
}

.text-div {
  position: fixed;
  bottom: 0;
  display: flex;
  align-items: center;
  width: 100%;
  padding: 8px;
  border-top: .5px solid #EFEFEF;
  background-color: #FFFFFF;
  box-shadow: 0px -1px 4px #DDD;
}

.text {
  flex: 1;
  padding: 6px 8px;
  margin: 0 8px 0 0;
  max-height: 60px;
  height: 32px;
  line-height: 16px;
  color: #424242;
  font-size: 15px;
  outline: none;
  border: .5px solid #BBB;
  border-radius: 4px;
  overflow-x: hidden;
}

.button {
  display: inline-block;
  padding: 4px 8px;
  background-color: #02A6F7;
  color: #FFFFFF;
  border-radius: 4px;
  box-shadow: 1px 1px 4px #BBB;
}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import atypes from '@/store/action-types'
import ChatItem from './ChatItem'
import { MessageBox,Toast } from 'mint-ui'
import Rongyun from '@/common/util/rongyun'
import Database from '@/common/util/database'

export default {
  name: 'Chat',
  data() {
    return {
      text: ''
    }
  },
  components: {
    ChatItem
  },
  created() {
    
  },
  beforeDestroy() {
    if (this.newchats.length) {
      //组件销毁前，保存到本地数据库
      this.$store.dispatch(atypes.SAVE_TO_INDEXEDDB, {
        userid: this.user.userid,
        friendid: this.chatfriend.friend_id
      }).then(() => {

      }).catch(error => {
        Toast({
          message: error,
          position: 'bottom',
          duration: 2000
        })
      })
    }
  },
  methods: {
    sendMessage() {
      if(this.text.length > 0) {
        //发送信息
        let chat = {
          from: this.user.userid,
          to: this.chatfriend.friend_id,
          content: this.text,
          failed: true,
          unopen: false
        }
        this.text = ''
        this.$store.commit(types.ADD_CHAT_CHAT, chat)
        Rongyun.sendMessage(chat.to, chat.content, this.newchats[this.newchats.length-1].id)
        .then(() => {
        }).catch(info => {
          console.log(info)
          Toast({
            message: '网络发生错误',
            position: 'bottom',
            duration: 2000
          })
        })
      } else {
        Toast({
          message: '不能发送空消息',
          position: 'bottom',
          duration: 2000
        })
      }
    },
    backward() {
      if(this.text.length > 0) {
        MessageBox.confirm('您还有未发送的消息，返回将不保留。是否返回？').then(action => {
          this.$router.back()
        })
      } else {
        this.$router.back()
      }
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'chats',
      'newchats',
      'chatfriend'
    ]),
    getMessages() {
      return this.chats.filter(item => (item.from==this.chatfriend.friend_id) || (item.to==this.chatfriend.friend_id && item.from==this.user.userid))
    }
  }
}
</script>

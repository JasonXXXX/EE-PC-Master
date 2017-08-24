<template>
  <div class="chat-div">
    <div class="message-content">
      <chat-item v-for="chatmsg in getMessages" :chatmsg="chatmsg" :key="chatmsg.id"></chat-item>
    </div>
    <div class="text-div">
      <el-input class="text" :type="textarea" :rows="input_rows" v-model.trim="text">
        </elin>
        <el-button class="button" @click="sendMessage">发送</el-button>
    </div>
  </div>
</template>

<style lang="css" scoped>
  .chat-div {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
  }

  .message-content {
    flex: 1;
  }

  .text-div {
    position: relative;
  }

  .text {
    height: 100%;
    width: 100%;
  }

  .button {
    position: absolute;
    bottom: 4px;
    right: 4px;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import atypes from '@/store/action-types'
import ChatItem from './ChatItem'
import Rongyun from '@/common/util/rongyun'
import Database from '@/common/util/database'

export default {
  name: 'Chat',
  data () {
    return {
      text: '',
      input_rows: 3
    }
  },
  components: {
    ChatItem
  },
  created () {

  },
  beforeDestroy () {
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
    sendMessage () {
      if (this.text.length > 0) {
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
        Rongyun.sendMessage(chat.to, chat.content, this.newchats[this.newchats.length - 1].id)
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
    backward () {
      if (this.text.length > 0) {
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
    getMessages () {
      return this.chats.filter(item => (item.from == this.chatfriend.friend_id) || (item.to == this.chatfriend.friend_id && item.from == this.user.userid))
    }
  }
}
</script>

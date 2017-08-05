<template>
	<div class="message-item">
    <img class="headimg" v-if="!(chatmsg.from==user.userid)" :src="chatfriend.friend_headimg">
    <p class="holder" v-if="chatmsg.from==user.userid"></p>
    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true" v-if="chatmsg.from==user.userid && chatmsg.failed" @click="send"></span>
    <p :class="['content', chatmsg.from==user.userid ? 'user' : 'friend']">{{chatmsg.content}}</p>
    <p class="holder" v-if="!(chatmsg.from==user.userid)"></p>
    <router-link to="/userdetail"><img class="headimg" v-if="chatmsg.from==user.userid" :src="user.headimg"></router-link>
  </div>
</template>

<style lang="css" scoped>
.message-item {
  display: flex;
  padding: 0;
  margin: 0;
  width: 100%;
}

.headimg {
  display: inline-block;
  padding: 0;
  margin: 8px;
  width: 32px;
  height: 32px;
  border-radius: 4px;
  box-shadow: 1px 1px 4px #CCCCCC;
}

.holder {
  flex: 1;
  min-width: 56px;
}

.content {
  margin: 6px 0;
  padding: 8px;
  width: auto;
  border-radius: 6px;
  box-shadow: 1px 1px 4px #BBB;
}

.glyphicon {
  margin: 16px 8px 8px 8px;
  color: #FF3333;
}

.user {
  background-color: #02A8F9;
  color: #FFFFFF;
  text-align: right;
}

.friend {
  background-color: #FFFFFF;
  color: #424242;
  text-align: left;
}
</style>

<script>
import { mapGetters } from 'vuex'
import { Toast } from 'mint-ui'
import Rongyun from '@/common/util/rongyun'

export default {
  name: 'ChatItem',
  props: ['chatmsg'],
  data() {
    return {
    }
  },
  created() {
  },
  methods: {
    send() {
      //点击重新发送该消息
      Rongyun.sendMessage(this.chatfriend.friend_id, this.chatmsg.content, this.chatmsg.id)
      .then(() => {
        Toast({
          message: '消息重发成功',
          position: 'bottom',
          duration: 2000
        })
      }).catch(info => {
        Toast({
          message: '重新发送失败',
          position: 'bottom',
          duration: 2000
        })
      })
    },
    userDetail() {
      //点击自己头像跳转到自己详情页面
      this.$router.push('/userdetail')
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'chatfriend'
    ])
  }
}
</script>
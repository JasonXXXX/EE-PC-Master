<template>
  <div>
    <div class="title">
      <router-link class="router-link" to="/home/forum" replace><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
      <span>设置</span>
    </div>
    <header class="header"></header>
    <div class="setting-wrap" @click.stop="clearChatRecord">清除本地聊天记录</div>
    <div class="setting-wrap" @click.stop="modifyPassword">修改密码</div>
  </div>
</template>

<style scoped>
.setting-wrap {
  display: flex;
  align-items: center;
  margin: 8px 0;
  padding: 12px 8px;
  background-color: #FFFFFF;
  color: #525252;
  box-shadow: 0px 1px 4px #BBB;
}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types.js'
import { Toast, MessageBox } from 'mint-ui'
import Database from '@/common/util/database.js'

export default {
  name: 'Setting',
  data() {
    return {

    }
  },
  created() {

  },
  methods: {
    clearChatRecord() {
      let self = this
      MessageBox.confirm('确认清空本地聊天记录吗？').then(action => {
        Database.init(true).then(() => {
          Database.clear().then(() => {
            self.$store.commit(types.CLEAR_CHAT_CHATS)
            Database.close()
            Toast({
              message: '聊天记录已删除',
              position: 'bottom',
              duration: 2000
            })
          }).catch(() => {
            Toast({
              message: '删除失败，请重新删除',
              position: 'bottom',
              duration: 2000
            })
          })
        }).catch(error => {
          Toast({
            message: '访问本地数据失败，请重新删除',
            position: 'bottom',
            duration: 2000
          })
        })
      }).catch(cancle => {
        
      })
    },
    modifyPassword() {
      
    }
  },
  computed: {
    ...mapGetters([
      'chats'
    ])
  }
}
</script>

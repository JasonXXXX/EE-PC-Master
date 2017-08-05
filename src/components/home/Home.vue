<template>
  <div>
    <ee-header></ee-header>
    <router-view class="app-wrap"></router-view>
  </div>
</template>

<style scoped>
  .app-wrap {
    margin: 12px auto;
    max-width: 1024px;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import router from '@/router'
import Header from '~/header/Header'
import types from '@/store/types'
import { Message } from 'element-ui'
import Rongyun from '@/common/util/rongyun'
import Database from '@/common/util/database'

export default {
  name: 'Home',
  data() {
    return {
    }
  },
  components: {
    eeHeader: Header
  },
  created () {
    if (this.user.userid!==0) {
      Rongyun.setListenAndconnectRongyun()

      Database.init().then(() => {
        Database.select().then(result => {
          this.$store.commit(types.ADD_CHAT_CHATS, result)
        }).catch(error => {
          console.log(error)
          Message({
            showClose: true,
            message: '发生了一些错误，读取本地聊天记录失败',
            type: 'error'
          })
        })
      }).catch(error => {
        console.log(error)
        Message({
          showClose: true,
          message: '发生了一些错误，读取本地聊天记录失败',
          type: 'error'
        })
      })
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'loading'
    ])
  }
}
</script>
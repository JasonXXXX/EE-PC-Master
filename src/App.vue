<template>
  <div id="app" v-loading.fullscreen.lock="loading" element-loading-text="拼命加载中">
    <router-view></router-view>
  </div>
</template>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    width: 100%;
    min-width: 768px;
  }

  .config-wrap {
    display: flex;
    max-width: 1024px;
  }

  .config-wrap-tab {
    margin-top: 0;
    height: fit-content;
    box-shadow: 1px 2px 4px #BDBDBD;
  }

  .config-wrap-view {
    flex: 1;
    margin: 0 0 12px 12px;
    padding: 0;
    height: fit-content;
    border: .5px solid #EEEEEE;
    transition: all .6s ease;
  }

  .config-no-border {
    display: block;
    text-align: left;
    border: none;
    border-bottom: .5px solid #BDBDBD;
  }

  .config-no-list-hint {
    display: block;
    margin: 12px;
    text-align: left;
    color: #B8B8B8;
  }

  .el-message-box__close {
    overflow: hidden;
  }

  .el-carousel__container {
    height: 100%;
  }

  .el-submenu__title {
    overflow-y: hidden;
  }






  /*left*/

  .slide-left-enter-active {
    transition: all .3s ease-in-out;
  }

  .slide-left-leave-active {
    transition: all .6s ease;
  }

  .slide-left-enter,
  .slide-left-leave-active {
    transform: translateX(100%);
    opacity: 0;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import { Message } from 'element-ui'
import Rongyun from '@/common/util/rongyun'
import Database from '@/common/util/database'

export default {
  name: 'app',
  created () {
    if (this.user.userid !== 0) {
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

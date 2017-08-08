<template>
  <div class="config-wrap">
    <el-menu :default-active="forumState.toString()" class="el-menu-vertical-demo config-wrap-tab" @select="handleSelect">
      <el-menu-item index="1"><i class="el-icon-menu"></i>资讯</el-menu-item>
      <el-menu-item index="2"><i class="el-icon-information"></i>讨论</el-menu-item>
    </el-menu>
    <div class="config-wrap-view" :class="{ 'no-border':!getForums.length }">
      <span class="hint" v-if="!getForums.length">还没有人发贴，快来发帖吧</span>
      <forum-item v-for="item in getForums" :key="item.id" :item="item"></forum-item>
    </div>
  </div>
</template>

<style scoped>
  .no-border {
    border: none;
    display: block;
    text-align: left;
    box-shadow: 0px 0px 0px #FFFFFF;
  }

  .hint {
    display: block;
    margin: 12px;
    color: #B8B8B8;
  }
</style>

<script>
  import { mapGetters } from 'vuex'
  import types from '@/store/types'
  import atypes from '@/store/action-types'
  import ForumItem from './ForumItem'

  export default {
    name: 'Forum',
    data () {
      return {
        hasItems: false
      }
    },
    created () {
      this.$store.commit(types.UPDATE_HEADER_SELECTED, '/forum')
      if (this.getForums.length < 1) {
        this.fetchForums()
      }
    },
    components: {
      ForumItem
    },
    methods: {
      handleSelect (index) {
        this.$store.commit(types.UPDATE_FORUM_STATE, parseInt(index))
        if (this.getForums.length < 1) {
          this.fetchForums()
        }
      },
      fetchForums() {
        let params = new URLSearchParams()

        params.append('message_mark', this.forumState)
        params.append('index', this.getForums.length)

        this.$common.http.post(this.$common.api.MessageList, params)
          .then(response => {
            this.$store.commit(types.ADD_FORUM_NEWS, response.data)
          })
          .catch(error => {
            //测试数据
            let news = [{
              id: 2,
              mark: this.forumState,
              message_like: 2,
              send_time: '2017-7-26',
              sender_name: '尤雨溪',
              sender_mark: 2,
              title: '60分钟vue快速入门'
            },{
              id: 1,
              mark: this.forumState,
              message_like: 2,
              send_time: '2017-7-26',
              sender_name: '大神',
              sender_mark: 2,
              title: '你不知道的node.js'
            },{
              id: 3,
              mark: this.forumState,
              message_like: 2,
              send_time: '2017-7-26',
              sender_name: '大神',
              sender_mark: 2,
              title: '8天node.js快速入门'
             },{
              id: 4,
              mark: this.forumState,
              message_like: 2,
              send_time: '2017-7-26',
              sender_name: '大神',
              sender_mark: 2,
              title: '8天node.js快速入门'
             },{
              id: 5,
              mark: this.forumState,
              message_like: 2,
              send_time: '2017-7-26',
              sender_name: '阮一峰',
              sender_mark: 2,
              title: '7天es6快速入门'
            }]
            this.$store.commit(types.ADD_FORUM_NEWS, news)
          })
      }
    },
    computed: {
      ...mapGetters([
        'forumState',
        'forums',
        'favoriteList'
      ]),
      getForums () {
        return this.forums.filter(item => item.mark===this.forumState)
      }
    },
    watch: {
    }
  }
</script>
<template>
  <div class="config-wrap">
    <transition name="el-zoom-in-top">
      <el-menu :default-active="forumState.toString()" class="el-menu-vertical-demo config-wrap-tab" @select="handleSelect">
        <el-menu-item index="1">
          <i class="el-icon-menu"></i>{{$common.strings.forum_menu_news}}</el-menu-item>
        <el-menu-item index="2">
          <i class="el-icon-information"></i>{{$common.strings.forum_menu_discover}}</el-menu-item>
      </el-menu>
    </transition>
    <div :class="['config-wrap-view', {'config-no-border':!getForums.length}]">
      <span class="config-no-list-hint" v-if="!getForums.length">{{$common.strings.forum_no_list_hint}}</span>
      <forum-item v-for="item in getForums" :key="item.id" :item="item"></forum-item>

      <el-pagination layout="prev, pager, next" :total="notes.length" :page-size="pageSize" @current-change="handleCurrentChange"></el-pagination>
    </div>
  </div>
</template>

<style scoped>

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
      hasItems: false,
      pageSize: 10,
      currentPage: 1
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
    fetchForums () {
      let params = new URLSearchParams()

      params.append('message_mark', 0)
      params.append('index', this.getForums.length)

      this.$common.http.post(this.$common.api.MessageList, params)
        .then(response => {
          this.$store.commit(types.ADD_FORUM_NEWS, response.data)
        })
        .catch(error => {
        })
    },
    handleCurrentChange (page) {
      this.currentPage = page
    }
  },
  computed: {
    ...mapGetters([
      'forumState',
      'forums',
      'favoriteList'
    ]),
    getForums () {
      const data = this.forums.filter(item => item.message_mark === this.forumState)
      return (this.pageSize * (this.currentPage - 1) + this.pageSize) < data.length ? data.slice(this.pageSize * (this.currentPage - 1), this.pageSize * (this.currentPage - 1) + this.pageSize) : data.slice(this.pageSize * (this.currentPage - 1))
    }
  },
  watch: {
  }
}
</script>
<template>
  <transition name="el-zoom-in-center">
    <div class="header">
      <div class="wrap">
        <img class="logo" :src="logo" @click="routerToHome">
        <el-menu theme="dark" :default-active="headerSelected" class="el-menu-demo wrap-menu" mode="horizontal" router>
          <el-menu-item class="wrap-menu-item" index="/forum">
            <icon name="rss" class="wrap-icon"></icon>{{$common.strings.common_menu_forum}}</el-menu-item>
          <el-menu-item class="wrap-menu-item" index="/teacher">
            <icon name="graduation-cap" class="wrap-icon"></icon>{{$common.strings.common_menu_teacher}}</el-menu-item>
          <el-menu-item class="wrap-menu-item" index="/course">
            <icon name="tv" class="wrap-icon"></icon>{{$common.strings.common_menu_course}}</el-menu-item>
          <el-menu-item class="wrap-menu-item" index="/me">
            <icon name="user-circle-o" class="wrap-icon"></icon>{{$common.strings.common_menu_me}}</el-menu-item>
        </el-menu>
        <el-autocomplete class="wrap-search" placeholder="搜索" :trigger-on-focus="true" :fetch-suggestions="querySearchSuggestions" icon="search" @select="handleSearchSelect" v-model.trim="search"></el-autocomplete>
        <el-dropdown menu-align="end" @command="handleCommand">
          <span class="el-dropdown-link">
            <img class="wrap-user-img" :src="headimg">
            <i class="el-icon-caret-bottom el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item class="dropdown-item" command="/detail">资料</el-dropdown-item>
            <el-dropdown-item class="dropdown-item" command="/friend">好友</el-dropdown-item>
            <el-dropdown-item class="dropdown-item" command="/chart" :divided="true">网站</el-dropdown-item>
            <el-dropdown-item class="dropdown-item" command="/setting" :divided="true">设置</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
  </transition>
</template>

<style scoped>
  .header {
    width: 100%;
    padding: 0;
    background-color: #324157;
    box-shadow: 1px 2px 8px #BBBBBB;
  }

  .logo {
    height: 60px;
    width: 60px;
  }

  .wrap-user-img {
    height: 48px;
    width: 48px;
    border-radius: 8px;
    background-color: #FFFFFF;
  }

  .wrap {
    display: flex;
    align-items: center;
    margin: 0 auto;
    width: 100%;
    max-width: 1024px;
  }

  .wrap-icon {
    margin-right: 6px;
  }

  .wrap-menu {
    flex: 1;
    margin-top: 16px;
  }

  .wrap-user {
    margin-top: 16px;
    overflow-x: hidden;
  }

  .wrap-menu-item {
    display: flex;
    align-items: center;
    overflow-y: hidden;
  }

  .wrap-user {
    overflow: hidden;
  }

  .dropdown-item {
    padding: 0 24px;
  }

  .wrap-search {
    margin: 0 12px;
  }
</style>

<script>
import logo from '@/assets/icon.png'
import headimg from '@/assets/headimg.png'
import { mapGetters } from 'vuex'
import types from '@/store/types'
import Storage from '@/common/util/storage'

import 'vue-awesome/icons/rss'
import 'vue-awesome/icons/graduation-cap'
import 'vue-awesome/icons/tv'
import 'vue-awesome/icons/user-circle-o'

export default {
  name: 'Header',
  data () {
    return {
      logo: logo,
      headimg: headimg,
      activeIndex: 'detail',
      search: '',
    }
  },
  created () {
    this.initSearchSuggestions()
  },
  methods: {
    routerToHome () {
      this.$router.push('/')
    },
    handleCommand (command) {
      this.$router.push(command)
    },
    initSearchSuggestions () {
      this.$store.commit(types.ADD_SEARCH_RECORDS, JSON.parse(localStorage.getItem(Storage.search_record)) || [])

      this.cbcourses.forEach(item => {
        this.searchs.push({
          value: '课程: ' + item.content,
          id: item.course_id
        })
      })
      this.forums.forEach(item => {
        this.searchs.push({
          value: '论坛: ' + item.title,
          id: item.id
        })
      })
      this.friends.forEach(item => {
        this.searchs.push({
          value: '好友: ' + item.friend_name,
          id: item.friend_id
        })
      })
      this.homeworkUndone.forEach(item => {
        this.searchs.push({
          value: '作业: ' + item.title,
          id: item.id
        })
      })
      this.homeworkDone.forEach(item => {
        this.searchs.push({
          value: '作业: ' + item.title,
          id: item.id
        })
      })
      this.notes.forEach(item => {
        this.searchs.push({
          value: '笔记: ' + item.title,
          id: item.id
        })
      })
      this.teachers.forEach(item => {
        this.searchs.push({
          value: '教师: ' + item.name,
          id: item.id
        })
      })
      if (this.getPlan.content) {
        this.searchs.push({
          value: '计划: ' + this.getPlan.content
        })
      }
    },
    querySearchSuggestions (queryString, cb) {
      const results = queryString ? this.searchs.filter(this.createFilter(queryString)) : this.searchs
      // 调用 callback 返回建议列表的数据
      cb(results)
    },
    createFilter (queryString) {
      return suggestions => (suggestions.value.indexOf(queryString.toLowerCase()) !== -1)
    },
    handleSearchSelect (value) {
      if (value.value === '请输入关键字') {
        this.search = ''
      } else {

      }
    }
  },
  computed: {
    ...mapGetters([
      'headerSelected',
      'cbcourses',
      'forums',
      'friends',
      'homeworkUndone',
      'homeworkDone',
      'notes',
      'getPlan',
      'teachers',
      'searchs'
    ])
  },
  watch: {
    forums () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    },
    cbcourses () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    },
    friends () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    },
    homeworkUndone () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    },
    homeworkDone () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    },
    notes () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    },
    getPlan () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    },
    teachers () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    }
  }
}
</script>

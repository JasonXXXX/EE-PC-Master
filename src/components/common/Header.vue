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
        <el-autocomplete class="wrap-search" placeholder="搜索课程/资讯/教师" :trigger-on-focus="true" :fetch-suggestions="querySearchSuggestions" icon="search" @select="handleSearchSelect" v-model.trim="search"></el-autocomplete>
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
import Convert from '@/common/util/convert'

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
    // this.initSearchSuggestions()
  },
  methods: {
    routerToHome () {
      this.$router.push('/')
    },
    handleCommand (command) {
      this.$router.push(command)
    },
    initSearchSuggestions () {
      const s = localStorage.getItem(Storage.search_record)
      if(s) {
        this.$store.commit(types.ADD_SEARCH_RECORDS, JSON.parse(s))
      }

      this.cbcourses.forEach(item => {
        this.$store.commit(types.ADD_SEARCH_SEARCH, {
          value: '课程: ' + item.course_content,
          id: item.course_id
        })
      })
      this.forums.forEach(item => {
        this.$store.commit(types.ADD_SEARCH_SEARCH, {
          value: '资讯: ' + item.message_title,
          id: item.id,
          mark: item.mark
        })
      })
      this.teachers.forEach(item => {
        this.$store.commit(types.ADD_SEARCH_SEARCH, {
          value: '教师: ' + item.teacher_name + ',' + Convert.convertSubNumber(item.teacher_mark),
          id: item.teacherid
        })
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
      // 处理搜索时的点击事件
      this.$store.commit(types.ADD_SEARCH_RECORD, value)

      const text = value.value
      if (text === '请输入关键字') {
        this.search = ''
      } else {
        if (text.startsWith('课程')) {
          this.$store.commit(types.UPDATE_CBROOM_COURSE, this.courses.find(item => item.course_id==value.id))
          this.$router.push('/coursedetail')
        } else if (text.startsWith('资讯')) {
          this.$store.commit(types.UPDATE_FORUM_MESSAGEID, value.id)
          this.$router.push(value.mark===4? '/discoverdetail': 'newsdetail')
        } else if (text.startsWith('教师')) {
          this.$store.commit(types.UPDATE_TEACHER_TEACHERID, value.id)
          this.$router.push('/teacherdetail')
        }
      }
    },
    fetchTeachers () {
      let params = new URLSearchParams()

      params.append('submark', 0)
      params.append('index', 0)

      return this.$common.http.post(this.$common.api.TeacherList, params)
        // .then(response => {
        //   this.$store.commit(types.ADD_TEACHER_CHINA, response.data)
        // })
        // .catch(error => {
        // })
    },
    fetchForums () {
      let params = new URLSearchParams()

      params.append('message_mark', this.forumState)
      params.append('index', 0)

      return this.$common.http.post(this.$common.api.MessageList, params)
        // .then(response => {
        //   this.$store.commit(types.ADD_FORUM_NEWS, response.data)
        // })
        // .catch(error => {
        // })
    },
    fetchCourses () {
      let params = new URLSearchParams()

      params.append('index', 0)
      params.append('course_mark', this.cbroomState)

      return this.$common.http.post(this.$common.api.CourseList, params)
        // .then(response => {
        //   this.$store.commit(types.ADD_CBROOM_MICROLECTURE, response.data)
        // })
        // .catch(error => {
        // })
    },
    fetchAll() {
      const fetchs = [this.fetchCourses(), this.fetchForums(), this.fetchTeachers()]
      this.$common.http.all(fetchs).then(this.$common.http.spread((courses, forums, teachers) => {
        this.$store.commit(types.ADD_CBROOM_MICROLECTURE, courses)
        this.$store.commit(types.ADD_FORUM_NEWS, forums)
        this.$store.commit(types.ADD_TEACHER_CHINA, teachers)

        this.initSearchSuggestions()
      })).catch(error => {})
    }
  },
  computed: {
    ...mapGetters([
      'headerSelected',
      'cbcourses',
      'forums',
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
    teachers () {
      this.searchs.splice(0, this.searchs.length - 1)
      this.initSearchSuggestions()
    }
  }
}
</script>

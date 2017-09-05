<template>
  <div class="config-wrap">
    <transition name="el-zoom-in-top">
      <el-menu :default-active="cbroomState.toString()" class="el-menu-vertical-demo config-wrap-tab" @select="handleSelect">
        <el-menu-item class="wrap-nav" index="1">
          <icon class="wrap-nav-icon" name="play-circle"></icon>
          <span>{{$common.strings.cbroom_menu_micro}}</span>
        </el-menu-item>
        <!-- <el-menu-item class="wrap-nav" index="2">
                <icon class="wrap-nav-icon" name="youtube-play"></icon>
                <span>{{$common.strings.cbroom_menu_live}}</span>
              </el-menu-item> -->
      </el-menu>
    </transition>
    <div class="config-wrap-view wrap" :class="{ 'config-no-border':!getCourses.length }">
      <span class="config-no-list-hint" v-if="!getCourses.length">{{$common.strings.cbroom_no_course_hint}}</span>
      <course-item v-for="item in getCourses" :key="item.course_id" :item="item"></course-item>

      <el-pagination layout="prev, pager, next" :total="cbcourses.length" :page-size="pageSize" @current-change="handleCurrentChange"></el-pagination>
    </div>
  </div>
</template>

<style scoped>
.wrap {
  text-align: right;
}

.wrap-nav {
  display: flex;
  align-items: center;
}

.wrap-nav-icon {
  margin-right: 6px;
}

.no-border {
  border: none;
  display: block;
  text-align: left;
  box-shadow: 0px 0px 0px #FFFFFF;
}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import atypes from '@/store/action-types'
import Be from '@/assets/html.jpg'
import CourseItem from './CourseItem'
import 'vue-awesome/icons/play-circle'
import 'vue-awesome/icons/youtube-play'

export default {
  name: 'Forum',
  data() {
    return {
      hasItems: false,
      pageSize: 10,
      currentPage: 1
    }
  },
  created() {
    this.$store.commit(types.UPDATE_HEADER_SELECTED, '/course')
    if (this.getCourses.length < 1 && !this.configNet) {
      this.fetchCourses()
    }
  },
  components: {
    CourseItem
  },
  methods: {
    routerToVideoUpload() {
      this.$router.push('/videoupload')
    },
    handleSelect(index) {
      this.$store.commit(types.UPDATE_CBROOM_ISDONE, parseInt(index))
      if (this.getCourses.length < 1) {
        this.fetchCourses()
      }
    },
    fetchCourses() {
      let params = new URLSearchParams()

      params.append('index', this.getCourses.length)
      params.append('course_mark', this.cbroomState)

      this.$common.http.post(this.$common.api.CourseList, params)
        .then(response => {
          this.$store.commit(types.ADD_CBROOM_MICROLECTURE, response.data)
        })
        .catch(error => {
        })
    },
    handleCurrentChange(page) {
      this.currentPage = page
    }
  },
  computed: {
    ...mapGetters([
      'cbroomState',
      'cbcourses',
      'configNet'
    ]),
    getCourses() {
      const data = this.cbcourses.filter(item => item.course_mark == this.cbroomState)
      return (this.pageSize * (this.currentPage - 1) + this.pageSize) < data.length ? data.slice(this.pageSize * (this.currentPage - 1), this.pageSize * (this.currentPage - 1) + this.pageSize) : data.slice(this.pageSize * (this.currentPage - 1))
    }
  }
}
</script>

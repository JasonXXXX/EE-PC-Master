<template>
  <div class="config-wrap">
    <transition name="el-zoom-in-top">
      <el-menu :default-active="cbroomState.toString()" class="el-menu-vertical-demo config-wrap-tab" @select="handleSelect">
        <el-menu-item class="wrap-nav" index="1">
          <icon class="wrap-nav-icon" name="play-circle"></icon>
          <span>{{$common.strings.cbroom_menu_micro}}</span>
        </el-menu-item>
        <el-menu-item class="wrap-nav" index="2">
          <icon class="wrap-nav-icon" name="youtube-play"></icon>
          <span>{{$common.strings.cbroom_menu_live}}</span>
        </el-menu-item>
      </el-menu>
    </transition>
    <div class="config-wrap-view" :class="{ 'config-no-border':!getCourses.length }">
      <!-- <el-button type="primary" @click="routerToVideoUpload">{{$common.strings.video_upload_button}}</el-button> -->
      <span class="config-no-list-hint" v-if="!getCourses.length">{{$common.strings.cbroom_no_course_hint}}</span>
      <course-item v-for="item in getCourses" :key="item.course_id" :item="item"></course-item>
    </div>
  </div>
</template>

<style scoped>
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
  data () {
    return {
      hasItems: false
    }
  },
  created () {
    this.$store.commit(types.UPDATE_HEADER_SELECTED, '/course')
    if (this.getCourses.length < 1) {
      this.fetchCourses()
    }
  },
  components: {
    CourseItem
  },
  methods: {
    routerToVideoUpload () {
      this.$router.push('/videoupload')
    },
    handleSelect (index) {
      this.$store.commit(types.UPDATE_CBROOM_ISDONE, parseInt(index))
      if (this.getCourses.length < 1) {
        this.fetchCourses()
      }
    },
    fetchCourses () {
      let params = new URLSearchParams()

      params.append('studentid', this.user.userid)
      params.append('index', this.getCourses.length)
      params.append('isdone1', this.cbroomState)

      this.$common.http.post(this.$common.api.CourseList, params)
        .then(response => {
          this.$store.commit(types.ADD_CBROOM_MICROLECTURE, response.data)
        })
        .catch(error => {
          //测试数据
          let microlectures = [{
            course_id: 1,
            coursemark: this.cbroomState,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be,
            fee: 99.99
          },
          {
            course_id: 1,
            coursemark: this.cbroomState,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be,
            fee: 99.99

          },
          {
            course_id: 1,
            coursemark: this.cbroomState,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be,
            fee: 99.99

          },
          {
            course_id: 1,
            coursemark: this.cbroomState,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be,
            fee: 99.99

          },
          {
            course_id: 1,
            coursemark: this.cbroomState,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be,
            fee: 99.99

          },
          {
            course_id: 1,
            coursemark: this.cbroomState,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be,
            fee: 99.99

          }]
          this.$store.commit(types.ADD_CBROOM_MICROLECTURE, microlectures)
        })
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'cbroomState',
      'cbcourses'
    ]),
    getCourses () {
      return this.cbcourses.filter(item => item.coursemark == this.cbroomState)
    }
  },
  watch: {
  }
}
</script>
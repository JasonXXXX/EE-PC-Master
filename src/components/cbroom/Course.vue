<template>
  <div class="config-wrap">
    <el-menu :default-active="cbroomState.toString()" class="el-menu-vertical-demo config-wrap-tab" @select="handleSelect">
      <el-menu-item class="wrap-nav" index="1"><icon class="wrap-nav-icon" name="play-circle"></icon><span>微课程</span></el-menu-item>
      <el-menu-item class="wrap-nav" index="2"><icon class="wrap-nav-icon" name="youtube-play"></icon><span>直播课</span></el-menu-item>
    </el-menu>
    <div class="config-wrap-view" :class="{ 'no-border':!getCourses.length }">
      <span class="hint" v-if="!getCourses.length">暂无已发布的课程，请耐心等候</span>
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
  import Be from '@/assets/be.jpg'
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
      handleSelect (index) {
        this.$store.commit(types.UPDATE_CBROOM_ISDONE, parseInt(index))
        if (this.getCourses.length < 1) {
          this.fetchCourses()
        }
      },
      fetchCourses() {
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
        return this.cbcourses.filter(item => item.coursemark==this.cbroomState)
      }
    },
    watch: {
    }
  }
</script>
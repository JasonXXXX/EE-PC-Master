<template>
  <div>
    <course-item v-for="item in courseLearning" :key="item.record_id" :item="item"></course-item>
    <span class="config-no-list-hint" v-if="!courseLearning.length">{{$common.strings.no_course_hint}}</span>
  </div>
</template>

<style scoped>

</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import img from '@/assets/be.jpg'
import CourseItem from './CourseItem'

export default {
  name: 'CourseLearning',
  data() {
    return {
      allLoaded: false,
      autoFill: false
    }
  },
  components: {
    CourseItem
  },
  created() {
    if (this.courseLearning.length === 0) {
      //该列表写暂无内容，进行访问
      this.fetchUnfinishedCourses()
    }
    this.$store.commit(types.UPDATE_COURSE_ISDONE, 1)
  },
  methods: {
    fetchUnfinishedCourses() {
      let params = new URLSearchParams()
      params.append('student_id', this.user.userid)
      params.append('index', this.courseLearning.length)
      params.append('isdone', 1)
      this.$common.http.post(this.$common.api.StudentCourseRecordList, params)
        .then(response => {
          this.$store.commit(types.ADD_COURSE_LEARNING, response.data)
        })
        .catch(error => {
          //测试数据
          // let courses = [{
          //   courseid: 1,
          //   title: '如何学好vue这个框架',
          //   teacher: 'jason',
          //   date: '2017-04-23',
          //   course_image: img
          // }, {
          //   courseid: 2,
          //   title: '如何学好react这个框架',
          //   teacher: 'jason',
          //   date: '2017-04-23',
          //   course_image: img
          // }]
          // this.$store.commit(types.ADD_COURSE_LEARNING, courses)
        })
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'courseLearning'
    ])
  }
}
</script>
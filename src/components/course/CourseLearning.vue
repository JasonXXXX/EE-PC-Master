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
    if (this.courseLearning.length === 0 && !this.configNet) {
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
          if (this.$common.jsonUtil.jsonLength(response.data) < 5) {
            this.allLoaded = true
          }
          this.$store.commit(types.ADD_COURSE_LEARNING, response.data)
        })
        .catch(error => {
        })
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'courseLearning',
      'configNet'
    ])
  }
}
</script>
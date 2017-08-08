<template>
	<div>
    <course-item v-for="item in courseLearned" :key="item.courseid" :item="item"></course-item>
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
	name: 'CourseLearned',
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
		if (this.courseLearned.length === 0) {
		  //该列表写暂无内容，进行访问
		  this.fetchFinishedCourses()
		}
    this.$store.commit(types.UPDATE_COURSE_ISDONE, 2)
	},
	methods: {
    fetchFinishedCourses() {
      let params = new URLSearchParams()
      params.append('studentid', this.user.userid)
      params.append('index', this.courseLearned.length)
      params.append('isdone', 2)
      this.$common.http.post(this.$common.api.StudentCourseRecordList, params)
        .then(response => {
          if (this.$common.jsonUtil.jsonLength(response.data) < 5) {
          	this.allLoaded = true
          }
          this.$store.commit(types.ADD_COURSE_LEARNED, { courses: response.data })
        })
        .catch(error => {
          //测试数据
          let courses = [{
            courseid: 1,
            title: '22222如何学好vue这个框架',
            teacher: 'jason',
            date: '2017-04-23',
            course_image: img
          }, {
            courseid: 2,
            title: '222222如何学好react这个框架',
            teacher: 'jason',
            date: '2017-04-23',
            course_image: img
          }]
          this.$store.commit(types.ADD_COURSE_LEARNED, { courses: courses })
        })
    }
	},
	computed: {
    ...mapGetters([
      'user',
      'courseLearned'
    ])
  }
}
</script>
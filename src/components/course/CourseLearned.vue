<template>
	<transition name="slide-left">
		<div>
			<loadmore :top-method="loadTop" :bottom-method="loadBottom" :bottom-all-loaded="allLoaded" ref="loadMore" :auto-fill="autoFill">
			  <div class="course-list-div" v-for="course in courseLearned" :key="course.courseid" @click="showDetail(course.courseid, course.title)">
			    <p class="course-title">{{course.title}}</p>
			    <p class="course-teacher">
			      <span class="course-teacher-span">课程老师:{{course.teacher}}</span>
			      <span class="">{{course.date}}</span>
			    </p>
			  </div>
			</loadmore>
		</div>
	</transition>
</template>

<style scoped>
.course-list-div {
  padding: 1rem;
  border-bottom: .5px solid #AAA;
}

.course-title {
  margin: 0 0 1rem 0;
  font-size: 16px;
}

.course-teacher {
  display: flex;
  align-items: center;
  padding: 0;
  margin: 0;
  color: #999;
  font-size: 13px;
}

.course-teacher-span {
  flex-grow: 1;
}

.course-list-div .glyphicon {
  float: right;
  right: 8px;
  margin-bottom: 4px;
  line-height: 60px;
}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import { Toast, Loadmore } from 'mint-ui'

export default {
	name: 'CourseLearned',
	data() {
		return {
			allLoaded: false,
			autoFill: false
		}
	},
  components: {
    Loadmore
  },
	created() {
		if (this.courseLearned.length === 0) {
		  //该列表写暂无内容，进行访问
		  this.fetchFinishedCourses()
		}
    this.$store.commit(types.UPDATE_COURSE_ISDONE, 2)
	},
	methods: {
		loadTop() {
      this.fetchFinishedCourses()
    },
    loadBottom() {
      this.fetchFinishedCourses()
    },
    showDetail(courseid, title) {
      //动态指定路由地址，并传递参数
      this.$router.push({
        path: '/coursedetail/' + courseid + '/title/' + title
      })
    },
    fetchFinishedCourses() {
      let params = new URLSearchParams()
      params.append('studentid', this.getUser.userid)
      params.append('index', this.courseLearned.length)
      params.append('isdone', 2)
      this.$common.http.post(this.$common.api.StudentCourseRecordList, params)
        .then(response => {
          if (this.$common.jsonUtil.jsonLength(response.data) < 5) {
            Toast({
              message: '数据已全部加载 :)',
              position: 'bottom',
              duration: 2000
            })
          	this.allLoaded = true
          }
          this.$store.commit(types.ADD_COURSE_LEARNED, { courses: response.data })
          this.$refs.loadMore.onTopLoaded()
          this.$refs.loadMore.onBottomLoaded()
        })
        .catch(error => {
          //测试数据
          let courses = [{
            courseid: 1,
            title: '22222如何学好vue这个框架',
            teacher: 'jason',
            date: '2017-04-23'
          }, {
            courseid: 2,
            title: '222222如何学好react这个框架',
            teacher: 'jason',
            date: '2017-04-23'
          }]
          this.$store.commit(types.ADD_COURSE_LEARNED, { courses: courses })
          this.$refs.loadMore.onTopLoaded()
          this.$refs.loadMore.onBottomLoaded()
        })
    }
	},
	computed: {
    ...mapGetters([
      'courseLearned'
    ]),
    ...mapGetters({
      getUser: 'user'
    })
  }
}
</script>
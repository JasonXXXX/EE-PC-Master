<template>
	<transition name="slide-right">
		<div>
			<loadmore :top-method="loadTop" :bottom-method="loadBottom" :bottom-all-loaded="allLoaded" ref="loadMore" :auto-fill="autoFill">
			  <div class="course-list-div" v-for="course in courseLearning" :key="course.courseid" @click="showDetail(course.courseid, course.title)">
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
	name: 'CourseLearning',
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
		if (this.courseLearning.length === 0) {
		  //该列表写暂无内容，进行访问
		  this.fetchUnfinishedCourses()
		}
		this.$store.commit(types.UPDATE_COURSE_ISDONE, 1)
	},
	methods: {
		loadTop() {
      this.fetchUnfinishedCourses()
    },
    loadBottom() {
      this.fetchUnfinishedCourses()
    },
    showDetail(courseid, title) {
      //动态指定路由地址，并传递参数
      this.$router.push({
        path: '/coursedetail/' + courseid + '/title/' + title
      });
    },
    fetchUnfinishedCourses() {
      let params = new URLSearchParams()
      params.append('studentid', this.getUser.userid)
      params.append('index', this.courseLearning.length)
      params.append('isdone', 1)
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
          this.$store.commit(types.ADD_COURSE_LEARNING, { courses: response.data })
          this.$refs.loadMore.onTopLoaded()
          this.$refs.loadMore.onBottomLoaded()
        })
        .catch(error => {
          //测试数据
          let courses = [{
            courseid: 1,
            title: '如何学好vue这个框架',
            teacher: 'jason',
            date: '2017-04-23'
          }, {
            courseid: 2,
            title: '如何学好react这个框架',
            teacher: 'jason',
            date: '2017-04-23'
          }]
          this.$store.commit(types.ADD_COURSE_LEARNING, { courses: courses })
          this.$refs.loadMore.onTopLoaded()
          this.$refs.loadMore.onBottomLoaded()
        })
    }
	},
	computed: {
    ...mapGetters([
      'courseLearning'
    ]),
    ...mapGetters({
      getUser: 'user'
    })
  }
}
</script>
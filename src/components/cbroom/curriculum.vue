<template>
  <transition name="slide-left">
    <div>
      <loadmore :top-method="loadTop" :bottom-method="loadBottom" :bottom-all-loaded="allLoaded" ref="loadMore" :auto-fill="autoFill">
        <div class="course-list-div" v-for="curriculums in curriculum" :key="curriculums.course_id" @click="showDetail(curriculums.course_id, curriculums.content)">
          <div class="course-image"><img v-lazy="curriculums.course_image"/></div>
          <div class="course-title"><p>{{curriculums.content}}</p></div>
          <div><p class="course-teacher">
            <span class="course-teacher-span">课程老师:{{curriculums.teachername}}</span>
            <span class="">时长：{{curriculums.duration}}</span>
          </p>
          </div>
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
.course-image{
  width: 100%;
  height: auto;
}
.course-title {
  margin: 1rem 0;
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
import Be from '@/assets/be.jpg'

export default {
  name: 'curriculum',
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
    if (this.curriculum.length === 0) {
      //该列表写暂无内容，进行访问
      this.fetchData()
    }
    this.$store.commit(types.UPDATE_CBROOM_ISDONE, 2)
  },
  methods: {
    loadTop() {
      this.fetchData()
    },
    loadBottom() {
      this.fetchData()
    },
    showDetail(course_id, content) {
      //动态指定路由地址，并传递参数
      this.$router.push({
        path: '/curriculumdetail/' + course_id + '/title/' + content 
      });
    },
    fetchData() {
      let params = new URLSearchParams()
      params.append('studentid', this.getUser.userid)
      params.append('index', this.curriculum.length)
      params.append('isdone1', 2)
      this.$common.http.post(this.$common.api.CourseList, params)
        .then(response => {
          if (this.$common.jsonUtil.jsonLength(response.data) < 5) {
            Toast({
              message: '数据已全部加载 :)',
              position: 'bottom',
              duration: 2000
            })
            this.allLoaded = true
          }
          this.$store.commit(types.ADD_CBROOM_CURRICULUM, { curriculums: response.data })
          this.$refs.loadMore.onTopLoaded()
          this.$refs.loadMore.onBottomLoaded()
        })
        .catch(error => {
          //测试数据
          let curriculums = [{
            course_id: 1,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be
          }, 
          {
            course_id: 1,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be

          },
          {
            course_id: 1,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be

          },
          {
            course_id: 1,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be

          },
          {
            course_id: 1,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be

          },
          {
            course_id: 1,
            course_image: Be,
            content: '掌握be动词的用法',
            teachername: 'jason',
            duration: '2h',
            course_vedio: Be

          }]
          this.$store.commit(types.ADD_CBROOM_CURRICULUM, { curriculums: curriculums })
          this.$refs.loadMore.onTopLoaded()
          this.$refs.loadMore.onBottomLoaded()
        })
    }
  },
  computed: {
    ...mapGetters([
      'curriculum'
    ]),
    ...mapGetters({
      getUser: 'user'
    })
  }
}
</script>
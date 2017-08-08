<template>
  <transition name="slide-right">
    <div>
      <loadmore :top-method="loadTop" :bottom-method="loadBottom" :bottom-all-loaded="allLoaded" ref="loadMore" :auto-fill="autoFill">
        <div class="course-list-div" v-for="microlectures in microlecture" :key="microlectures.course_id" @click="showDetail(microlectures.course_id, microlectures.content)">
          <div class="course-image"><img v-lazy="microlectures.course_image"/></div>
          <div class="course-title"><p>{{microlectures.content}}</p></div>
          <div><p class="course-teacher">
            <span class="course-teacher-span">课程老师:{{microlectures.teachername}}</span>
            <span class="">时长：{{microlectures.duration}}</span>
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
  name: 'microlecture',
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
    if (this.microlecture.length === 0) {
      //该列表写暂无内容，进行访问
      this.fetchData()
    }
    this.$store.commit(types.UPDATE_CBROOM_ISDONE, 1)
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
        path: '/microlecturedetail/' + course_id + '/title/' + content
      });
    },

  },
  computed: {
    ...mapGetters([
      'microlecture'
    ]),
    ...mapGetters({
      getUser: 'user'
    })
  }
}
</script>
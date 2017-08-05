<template>
  <div class="slide-course-div">
    <div class="title">
      <router-link class="router-link" to="/home/forum" replace><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
      <span>课程</span>
    </div>
    <header class="header">
      <router-link :class="['course-link', isdone===1? 'selected': 'unselected']" to="/course">正在学</router-link>
      <router-link :class="['course-link', isdone===1? 'unselected': 'selected']" to="/course/learned">历史课程</router-link>
    </header>
    <!--数据列表 -->
    <router-view></router-view>
  </div>
</template>

<style scoped>
.header {
  display: flex;
}

.course-link {
  flex: 1;
  display: inline-block;
  padding: 8px 0;
  text-align: center;
}

.selected {
  color: #2682FF;
}

.unselected {
  color: #727272;
}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'

export default {
  name: 'Course',
  data() {
    return {
      current: true
    }
  },
  created() {
    if(this.isdone===2) {
      this.$router.replace('/course/learned')
    }
  },
  beforeRouteLeave (to, from, next) {
    //返回前取消正在进行的请求
    
    //返回前清空数据
    this.$store.commit(types.CLEAR_COURSE_COURSES)
    this.$store.commit(types.UPDATE_COURSE_ISDONE, 'learning')
    next()
  },
  methods: {
    
  },
  computed: {
    ...mapGetters([
      'isdone'
    ])
  }
}
</script>
<template>
  <div class="slide-course-div">
    <!-- <div class="title">
      <router-link class="router-link" to="/home"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
      <span>课程直播间</span>
    </div> -->
    <header class="header">
      <router-link :class="['course-link', isdone1===1? 'selected': 'unselected']" to="/cbroom">微课</router-link>
      <router-link :class="['course-link', isdone1===1? 'unselected': 'selected']" to="/cbroom/curriculum">课程</router-link>
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
    if(this.isdone1===2) {
      this.$router.replace('/cbroom/microlecture')
    }
  },
  beforeRouteLeave (to, from, next) {
    //返回前取消正在进行的请求
    
    //返回前清空数据
    this.$store.commit(types.CLEAR_CBROOM_CBROOM)
    this.$store.commit(types.UPDATE_CBROOM_ISDONE, 'curriculum')
    next()
  },
  methods: {
    
  },
  computed: {
    ...mapGetters([
      'isdone1'
    ])
  }
}
</script>
<template>
  <div>
    <div class="teacher">
      <router-link class="teacher-item" to="/home/teacher/1">
        <span class="teacher-link">语 文</span>
      </router-link> 
      <router-link tag="div" class="teacher-item" to="/home/teacher/2">
        <span class="teacher-link">数 学</span>
      </router-link>
      <router-link tag="div" class="teacher-item" to="/home/teacher/3">
        <span class="teacher-link">英 语</span>
      </router-link>
      <router-link tag="div" class="teacher-item" to="/home/teacher/4">
        <span class="teacher-link">物 理</span>
      </router-link>
      <router-link tag="div" class="teacher-item" to="/home/teacher/5">
        <span class="teacher-link">化 学</span>
      </router-link>
      <router-link tag="div" class="teacher-item" to="/home/teacher/6">
        <span class="teacher-link">生 物</span>
      </router-link>
      <router-link tag="div" class="teacher-item" to="/home/teacher/7">
        <span class="teacher-link">政 治</span>
      </router-link>
      <router-link tag="div" class="teacher-item" to="/home/teacher/8">
        <span class="teacher-link">历 史</span>
      </router-link>
      <router-link tag="div" class="teacher-item" to="/home/teacher/9">
        <span class="teacher-link">地 理</span>
      </router-link>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import types from '@/store/types'

  export default {
    name: 'Teacher',
    mounted() {
    },
    beforeRouteUpdate(to, from, next) {
      let id = to.path.split('/')[to.path.split('/').length-1]
      this.$store.commit(types.UPDATE_TEACHER_TEACHERMARK, id)
      next()
    }
  }
</script>

<style lang="stylus" rel="stylesheet/stylus" scoped>
  @import "~common/stylus/variable"
  .teacher
    display: flex
    height: 44px
    line-height: 44px
    font-size: $font-size-medium
    .teacher-item
      flex: 1
      text-align: center
      font-size:13px
      overflow-y: hidden
      .teacher-link
        padding: 4px
        color: black
        text-align: center
      &.router-link-active
        .teacher-link
          color: #0000FF
          font-size:13px
</style>
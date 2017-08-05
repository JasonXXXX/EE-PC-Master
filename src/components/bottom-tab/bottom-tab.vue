<template>
  <div>
    <router-view></router-view>
    <div class="tab">
      <router-link tag="div" class="tab-item" to="/home/forum/forum-news">
        <span class="tab-link">论坛</span>
      </router-link>
      <router-link tag="div" class="tab-item" to="/home/teacher">
        <div class="tab-link">教师</div>
      </router-link>
     <router-link tag="div" class="tab-item" to="/cbroom">
      <span class="tab-link">直播间</span>
    </router-link>
    </div>
  </div>
</template>

 <script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'BottomTab',
    data() {
      return {
      }
    },
    beforeRouteUpdate(to, from, next) {
      if (to.path.indexOf('teacher')!==-1 && to.path.indexOf('teacher/')===-1) {
        next(to.path + '/' + this.teachermark)
      } else {
        next()
      }
    },
    methods: {
      
    },
    computed: {
      ...mapGetters([
        'teachermark'
      ])
    }
  }
</script>

<style scoped lang="stylus">
  @import "~common/stylus/variable"
  .tab
    position: fixed;
    z-index: 19;
    background-color: #434343;
    left: 0;
    bottom: 0;
    right: 0;
    display: flex
    height: 44px
    line-height: 44px
    font-size: $font-size-medium
    .tab-item
      flex: 1
      text-align: center
      border-top: 1px solid $color-theme
      .tab-link
        display: inline-block
        padding-bottom: 5px
        width: 100%
        color: $color-text
      &.router-link-active
        .tab-link
          color: #FFFFFF
          border-bottom: 2px solid #FFFFFF
</style>
<template>
  <div class="config-wrap wrap-player">
    <div class="wrap-collapse" @click="handleBack">
      <i class="el-icon-arrow-left"></i>
      <span>{{$common.strings.course_collapse}}</span>
    </div>
    <video-player :video="video"></video-player>
  </div>
</template>

<style>
  .wrap-player {
    flex-direction: column;
    padding: 8px;
    width: 100%;
    height: auto;
  }
  
  .wrap-collapse {
    display: flex;
    align-items: center;
    padding: 8px 16px;
    margin: 4px 0;
    width: fit-content;
    color: #DDDDDD;
    border-bottom: 1px solid transparent;
    transition: all .6s ease;
  }
  
  .wrap-collapse:hover {
    color: #424242;
    border-bottom: 1px solid #BDBDBD;
  }
</style>

<script>
import VideoPlayer from './VideoPlayer'
import Storage from '@/common/util/storage'

export default {
  name: 'CourseDetail',
  data () {
    return {
      video: {
        src: 'http://localhost:8080/TestServer/video.mp4'
      }
    }
  },
  components: {
    VideoPlayer
  },
  create () {
  },
  methods: {
    playHappened () {

    },
    handleBack () {
      this.$router.back()
    }
  }
}
</script>
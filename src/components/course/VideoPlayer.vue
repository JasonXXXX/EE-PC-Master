<template>
  <div class="wrap">
    <video ref="videoer" @click="handleClick" class="wrap-video" :autoplay="autoplay" :controls="controls" :poster="poster" :src="video.src" :loop="loop" @onerror="handleVideoError"></video>
  </div>
</template>

<style scoped>
  .wrap {
    width: 100%;
    margin: 0;
    padding: 12px 0;
  }

  .wrap-video {
    width: 100%;
    height: auto;
    margin: 0 0 12px 0;
  }
</style>

<script>
import Pic from '@/assets/html.jpg'
import Database from '@/common/util/database'

export default {
  name: 'VideoPlayer',
  props: ['video'],
  data () {
    return {
      player: null,
      autoplay: false,
      controls: true,
      poster: Pic,
      loop: false
    }
  },
  created () {
    this.autoplay = this.video.autoplay || false
    this.loop = this.video.loop || false
    this.controls = this.video.controls || true
    this.poster = this.video.poster || Pic
  },
  mounted () {
    this.player = this.$refs.videoer
  },
  methods: {
    handleClick () {
      if (!this.player.paused) {
        this.player.pause()
        Database.init(true, Database.db.store_course).then(() => {
          Database.put({
            id: this.video.id,
            text: this.video.text,
            date: new Date()
          }, Database.db.store_course)
        }).catch(error => {
          console.log(error)
        })
      } else {
        this.player.play()
      }
    },
    handleVideoError () {
      this.$message({
        type: 'warning',
        message: this.video.error_text || '视频加载出错啦'
      })
    }
  }
}
</script>

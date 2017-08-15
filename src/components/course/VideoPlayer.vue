<template>
  <div class="wrap">
    <video ref="video" @click="handleClick" class="wrap-video" :autoplay="autoplay" :controls="controls" :poster="poster" :src="video.src" :loop="loop"></video>
  </div>
</template>

<style scoped>
  .wrap {
    width: 100%;
    margin: 0;
    padding: 12px;
  }
  
  .wrap-video {
    width: 100%;
    height: auto;
    margin: 0 0 12px 0;
  }
</style>

<script>
import Pic from '@/assets/html.jpg'

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
    this.player = this.$refs.video
  },
  methods: {
    handleClick () {
      if (!this.player.paused) {
        this.player.pause()
      } else {
        this.player.play()
      }
    }
  }
}
</script>

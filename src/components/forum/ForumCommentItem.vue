<template>
  <div class="wrap">
    <div class="wrap-author">
      <img :src="img" class="author-img">
      <span class="author-name">{{comment.name || ''}}</span>
      <span class="author-name">{{comment.send_time}}</span>
    </div>
    <p class="wrap-content">{{comment.content}}</p>
  </div>
</template>

<style scoped>
  .wrap {
    margin: 0;
    padding: 12px;
    border-bottom: .5px solid #BDBDBD;
  }

  .wrap-author {
    display: flex;
    align-items: center;
  }

  .author-img {
    display: inline-block;
    margin: 0 8px;
    height: 56px;
    width: 56px;
    border-radius: 50%;
  }

  .author-name {
    display: inline-block;
    margin: 0 4px;
    color: #959595;
    font-size: 13px;
  }

  .wrap-content {
    margin: 0;
    padding: 8px 8px 8px 64px;
    color: #424242;
    font-size: 15px;
  }
</style>

<script>
import img from '@/assets/headimg.png'
import Server from '@/common/data/server'

export default {
  name: 'ForumCommentItem',
  props: ['comment'],
  data () {
    return {
      img: ''
    }
  },
  created () {
    this.img = 'http://' + Server.ip + ':' + Server.port + '/' + Server.server + '/image/userheadimg/' + (this.comment.sender_mark===2? 'student': 'teacher') + this.comment.sender_id + '.png'
  }
}
</script>

<template>
  <transition name="el-fade-in">
    <div class="wrap" @click="routerToDetail">
      <img :src="img" class="wrap-img">
      <p class="wrap-name">{{item.teacher_name}}</p>
      <span class="wrap-intro">{{item.intro}}</span>
    </div>
  </transition>
</template>

<style scoped>
  .wrap {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 8px;
    margin: 0 8px 8px 8px;
    border-bottom: .5px solid #BDBDBD;
    transition: all .8s ease;
  }

  .wrap:hover {
    background-color: #EFEFEF;
    box-shadow: 1px 2px 12px #BBBBBB;
  }

  .wrap-img {
    display: block;
    padding: 8px;
    margin: 0 auto;
    width: 90px;
    height: 90px;
    box-shadow: 0px 1px 3px #BDBDBD;
    border-radius: 50%;
  }

  .wrap-name {
    margin: 8px 0 4px 0;
    font-size: 17px;
    color: #414141;
  }

  .wrap-intro {
    font-size: 13px;
    color: #939393;
  }
</style>

<script>
import Server from '@/common/data/server.js'
import Headimg from '@/assets/default-teacher-headimg.png'

export default {
  name: 'TeacherItem',
  props: ['item'],
  data () {
    return {
      img: Headimg
    }
  },
  mounted () {
    this.img = 'http://' + Server.ip + ':' + Server.port + '/' + Server.server + '/image/userheadimg/teacher' + this.teacherid + '.png'
  },
  methods: {
    routerToDetail () {
      this.$store.commit(types.UPDATE_TEACHER_TEACHERID, this.item.teacherid)
      this.$router.push('/teacherdetail')
    }
  }
}
</script>

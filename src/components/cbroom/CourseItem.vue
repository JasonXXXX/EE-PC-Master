<template>
  <transition name="el-zoom-in-top">
    <div class="wrap">
      <div class="wrap-img-div">
        <img class="wrap-img" :src="item.course_image" :alt="item.title">
        <div class="wrap-img-hover" @click="routerToCourseDetail">
          <icon class="wrap-img-play" name="play-circle-o"></icon>
        </div>
      </div>
      <div class="wrap-info">
        <p class="wrap-info-title" @click="routerToCourseDetail">{{item.content}}</p>
        <span class="wrap-info-addtive" v-if="item.coursemark===1 || item.coursemark===2">{{$common.strings.cbroom_course_teacher}}: {{item.teachername}}</span>
        <span class="wrap-info-addtive" v-if="item.coursemark===1">{{$common.strings.cbroom_course_duration}}: {{item.duration}}</span>
        <span class="wrap-info-addtive" v-if="item.coursemark===2">{{$common.strings.cbroom_course_fee}}:
          <span class="info-fee">&yen;{{item.fee}}</span>
        </span>
        </span>
      </div>
    </div>
  </transition>
</template>

<style scoped>
  .wrap {
    display: flex;
    align-items: center;
    margin: 0;
    padding: 12px;
    border-bottom: .5px solid #BDBDBD;
  }
  
  .wrap-img-div {
    position: relative;
    flex: 1;
    padding: 0;
    margin: 0 12px 0 0;
    min-width: 160px;
    height: auto;
    box-shadow: 1px 1px 4px #CCCCCC;
  }
  
  .wrap-img {
    float: left;
    width: 100%;
    height: auto;
    z-index: 10;
  }
  
  .wrap-img-hover {
    /* float: left; */
    position: absolute;
    top: 0;
    display: flex;
    align-items: center;
    height: 100%;
    width: 100%;
    background-color: #000000;
    opacity: 0;
    transition: all .6s ease;
    z-index: 20;
  }
  
  .wrap-img-hover:hover {
    opacity: 0.7;
  }
  
  .wrap-img-play {
    display: block;
    margin: 0 auto;
    width: 64px;
    height: 64px;
    color: #FFFFFF;
    z-index: 30;
  }
  
  .wrap-info {
    flex: 2;
    padding-left: 8px;
    text-align: left;
  }
  
  .wrap-info-title {
    padding: 4px 0;
    margin: 4px 0;
    color: #424242;
    font-size: 17px;
    border-bottom: 1.5px solid transparent;
    transition: all .6s ease;
  }
  
  .wrap-info-title:hover {
    padding-left: 4px;
    color: #000000;
    box-shadow: 1px 1px 8px #BDBDBD;
  }
  
  .wrap-info-addtive {
    display: inline-block;
    padding: 0;
    margin: 0 8px 0 0;
    color: #989898;
    font-size: 14px;
  }
  
  .info-fee {
    color: #4276FF;
  }
</style>

<script>
import 'vue-awesome/icons/play-circle-o'

export default {
  name: 'CourseItem',
  props: ['item'],
  methods: {
    routerToCourseDetail () {
      this.$router.push('/coursedetail')
    }
  }
}
</script>

<template>
  <transition name="el-zoom-in-top">
    <div class="wrap">
      <div class="wrap-img-div">
        <img class="wrap-img" :src="item.course_image" :alt="item.title">
      </div>
      <div class="wrap-info">
        <p class="wrap-info-title">{{item.title}}</p>
        <span class="wrap-info-addtive">{{$common.strings.course_item_teacher}}: {{item.teachername}}</span>
        <span class="wrap-info-addtive">{{$common.strings.course_item_time}}: {{item.date}}</span>
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
    flex: 1;
    padding: 0;
    margin: 0 12px 0 0;
    min-width: 160px;
    height: auto;
    box-shadow: 1px 1px 4px #CCCCCC;
  }

  .wrap-img {
    width: 100%;
    height: auto;
  }

  .wrap-info {
    flex: 2;
    padding-left: 8px;
    text-align: left;
  }

  .wrap-info-title {
    padding: 0;
    margin: 8px 0;
    color: #424242;
    font-size: 17px;
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
export default {
  name: 'CourseItem',
  props: ['item']
}
</script>

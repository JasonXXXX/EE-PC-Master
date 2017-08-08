<template>
  <transition name="el-fade-in">
    <div class="wrap">
      <img :src="item.headimg" class="wrap-img">
      <p class="wrap-name">{{item.name}}</p>
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
export default {
  name: 'TeacherItem',
  props: ['item']
}
</script>

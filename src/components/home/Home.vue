<template>
  <div class="app-div" scroll="no">
    <ee-header></ee-header>
    <router-view class="app-wrap"></router-view>
  </div>
</template>

<style scoped>
  .app-div {
    display: flex;
    flex-direction: column;
    height: fit-content;
    min-height: 100vh;
    width: 100%;
  }
  
  .app-wrap {
    flex: 1;
    margin: 12px auto 0 auto;
    width: 100%;
    box-shadow: 2px 2px 12px #BDBDBD;
  }
</style>

<script>
import Header from '~/common/Header'

export default {
  name: 'Home',
  data () {
    return {
    }
  },
  components: {
    eeHeader: Header
  }
}
</script>
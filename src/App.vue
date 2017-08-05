<template>
  <div
    id="app"
    v-loading.fullscreen.lock="loading"
    element-loading-text="拼命加载中">
    <router-view></router-view>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'app',
  computed: {
    ...mapGetters([
      'loading'
    ])
  }
}
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 12px;
    margin-left: auto;
    margin-right: auto;
    width: 100%;
    min-width: 768px;
  }

  .config-wrap {
    display: flex;
  }

  .config-wrap-view {
    flex: 1;
  }

  .config-wrap-tab {
    height: fit-content;
    box-shadow: 1px 2px 4px #BDBDBD;
  }

  /*left*/

  .slide-left-enter-active {
    transition: all .3s ease-in-out;
  }

  .slide-left-leave-active {
    transition: all .6s ease;
  }

  .slide-left-enter,
  .slide-left-leave-active {
    transform: translateX(100%);
    opacity: 0;
  }
</style>

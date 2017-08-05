<template>
  <div>
    <ee-header></ee-header>
    <router-view class="app-wrap"></router-view>
  </div>
</template>

<style scoped>
  .app-wrap {
    margin: 12px auto;
    max-width: 1024px;
  }
</style>

<script>
import Header from '~/header/Header'

export default {
  name: 'Home',
  data() {
    return {
    }
  },
  components: {
    eeHeader: Header
  }
}
</script>
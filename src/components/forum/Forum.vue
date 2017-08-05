<template>
  <div class="config-wrap">
    <el-menu default-active="1" class="el-menu-vertical-demo config-wrap-tab" @open="handleOpen" @close="handleClose">
      <el-menu-item index="1"><i class="el-icon-menu"></i>资讯</el-menu-item>
      <el-menu-item index="2"><i class="el-icon-setting"></i>讨论</el-menu-item>
    </el-menu>
    <router-view class="config-wrap-view"></router-view>
  </div>
</template>

<script>
  export default {
    name: 'Forum',
    created() {
      console.log('forum created')
    },
    methods: {
      handleOpen(key, keyPath) {
        console.log(key, keyPath)
      },
      handleClose(key, keyPath) {
        console.log(key, keyPath)
      }
    }
  }
</script>

<style scoped>

</style>
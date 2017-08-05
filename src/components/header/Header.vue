<template>
  <div class="header">
    <div class="wrap">
      <img class="logo" :src="logo">
      <el-tabs class="wrap-tab" v-model="headerSelected" @tab-click="handleClick">
        <el-tab-pane label="论坛" name="forum"></el-tab-pane>
        <el-tab-pane label="教师" name="teacher"></el-tab-pane>
        <el-tab-pane label="课程观看" name="course"></el-tab-pane>
        <el-tab-pane label="我的" name="personal"></el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<style scoped>
  .header {
    padding: 0 24px;
    background-color: #EFEFEF;
    box-shadow: 1px 2px 8px #BBBBBB;
  }

  .logo {
    height: 60px;
    width: 60px;
  }

  .wrap {
    display: flex;
    align-items: center;
    margin: 0 auto;
    width: 100%;
    max-width: 1024px;
  }

  .wrap-tab {
    flex: 1;
    margin-top: 16px;
    margin-bottom: -16px;
  }

</style>

<script>
import logo from '@/assets/icon.png'
import { mapGetters } from 'vuex'
import types from '@/store/types'

export default {
  name: 'Header',
  data () {
    return {
      logo: logo
    }
  },
  methods: {
    handleClick (tab, event) {
      this.$store.commit(types.UPDATE_HEADER_SELECTED, tab.name)
      this.$router.push('/home/' + tab.name)
    }
  },
  computed: {
    ...mapGetters([
      'headerSelected'
    ])
  }
}
</script>

<template>
  <div class="header">
    <div class="wrap">
      <img class="logo" :src="logo">
      <el-menu theme="dark" :default-active="headerSelected" class="el-menu-demo wrap-menu" mode="horizontal" router>
        <el-menu-item class="wrap-menu-item" index="/forum"><icon name="rss" class="wrap-icon"></icon>论坛</el-menu-item>
        <el-menu-item class="wrap-menu-item" index="/teacher"><icon name="graduation-cap" class="wrap-icon"></icon>教师</el-menu-item>
        <el-menu-item class="wrap-menu-item" index="/course"><icon name="tv" class="wrap-icon"></icon>观看课程</el-menu-item>
        <el-menu-item class="wrap-menu-item" index="/me"><icon name="user-circle-o" class="wrap-icon"></icon>我的</el-menu-item>
      </el-menu>
    </div>
  </div>
</template>

<style scoped>
  .header {
    padding: 0 24px;
    background-color: #324157;
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

  .wrap-icon {
    margin-right: 6px;
  }

  .wrap-menu {
    flex: 1;
    margin-top: 16px;
  }

  .wrap-menu-item {
    display: flex;
    align-items: center;
    overflow-y: hidden;
  }

</style>

<script>
import logo from '@/assets/icon.png'
import { mapGetters } from 'vuex'
import types from '@/store/types'

import 'vue-awesome/icons/rss'
import 'vue-awesome/icons/graduation-cap'
import 'vue-awesome/icons/tv'
import 'vue-awesome/icons/user-circle-o'

export default {
  name: 'Header',
  data () {
    return {
      logo: logo
    }
  },
  created () {
  },
  methods: {
  },
  computed: {
    ...mapGetters([
      'headerSelected'
    ])
  }
}
</script>

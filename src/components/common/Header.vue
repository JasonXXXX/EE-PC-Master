<template>
  <transition name="el-zoom-in-center">
    <div class="header">
      <div class="wrap">
        <img class="logo" :src="logo" @click="routerToHome">
        <el-menu theme="dark" :default-active="headerSelected" class="el-menu-demo wrap-menu" mode="horizontal" router>
          <el-menu-item class="wrap-menu-item" index="/forum">
            <icon name="rss" class="wrap-icon"></icon>{{$common.strings.common_menu_forum}}</el-menu-item>
          <el-menu-item class="wrap-menu-item" index="/teacher">
            <icon name="graduation-cap" class="wrap-icon"></icon>{{$common.strings.common_menu_teacher}}</el-menu-item>
          <el-menu-item class="wrap-menu-item" index="/course">
            <icon name="tv" class="wrap-icon"></icon>{{$common.strings.common_menu_course}}</el-menu-item>
          <el-menu-item class="wrap-menu-item" index="/me">
            <icon name="user-circle-o" class="wrap-icon"></icon>{{$common.strings.common_menu_me}}</el-menu-item>
        </el-menu>
        <el-dropdown menu-align="end" @command="handleCommand">
          <span class="el-dropdown-link">
            <img class="wrap-user-img" :src="headimg">
            <i class="el-icon-caret-bottom el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="/detail">资料</el-dropdown-item>
            <el-dropdown-item command="/friend">好友</el-dropdown-item>
            <el-dropdown-item command="/setting" :divided="true">设置</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
  </transition>
</template>

<style scoped>
  .header {
    width: 100%;
    padding: 0;
    background-color: #324157;
    box-shadow: 1px 2px 8px #BBBBBB;
  }
  
  .logo {
    height: 60px;
    width: 60px;
  }
  
  .wrap-user-img {
    height: 48px;
    width: 48px;
    border-radius: 8px;
    background-color: #FFFFFF;
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
  
  .wrap-user {
    margin-top: 16px;
    overflow-x: hidden;
  }
  
  .wrap-menu-item {
    display: flex;
    align-items: center;
    overflow-y: hidden;
  }
  
  .wrap-user {
    overflow: hidden;
  }
</style>

<script>
import logo from '@/assets/icon.png'
import headimg from '@/assets/headimg.png'
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
      logo: logo,
      headimg: headimg,
      activeIndex: 'detail'
    }
  },
  created () {
  },
  methods: {
    routerToHome () {
      this.$router.push('/')
    },
    handleCommand (command) {
      this.$router.push(command)
    }
  },
  computed: {
    ...mapGetters([
      'headerSelected'
    ])
  }
}
</script>

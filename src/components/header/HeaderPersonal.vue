<template>
  <transition name="slide-left">
      <div class="header-personal">
      <el-menu theme="gray" default-active="1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose">
        <el-submenu index="1">
          <template slot="title"><i class="el-icon-message"></i>{{user.name}}</template>
          <el-menu-item-group>
            <template slot="title">进度</template>
            <el-menu-item index="1-1">
              <router-link class="header-link" to="/personal">课程</router-link>
            </el-menu-item>
            <el-menu-item index="1-2">
              <router-link class="header-link" to="/personal/homework">作业</router-link>
            </el-menu-item>
            <el-menu-item index="1-3">
              <router-link class="header-link" to="/personal/note">笔记</router-link>
            </el-menu-item>
            <el-menu-item index="1-4">
              <router-link class="header-link" to="/personal/plan">计划</router-link>
            </el-menu-item>
          </el-menu-item-group>

          <el-menu-item-group title="圈子">
            <el-menu-item index="1-5">
              <router-link class="header-link" to="/personal/friend">好友</router-link>
            </el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-menu-item index="2"><i class="el-icon-setting"></i>设置</el-menu-item>
        <el-menu-item index="3"><i class="el-icon-setting"></i>退出登录</el-menu-item>
      </el-menu>
    </div>
  </transition>
</template>

<style scoped>
  .header-personal {
    margin: 0 0 0 12px;
  }

  .headimg {
     display: inline-block; 
    margin: 0 8px;
    height: 60px;
    width: 60px;
    border-radius: 2px;
  }

  .header-link {
    text-decoration: none;
    color: #424242;
  }

  .el-menu-item-group__title {
    text-align: left;
    padding-left: 8px;
  }

  .el-submenu-icon__arrow {
    left: 24px;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import Img from '@/assets/headimg.png'

export default {
  name: 'HeaderHome',
  data () {
    return {
      activeIndex: '1',
      headimg: Img
    }
  },
  created () {
    console.log('Header created')
  },
  methods: {
    handleOpen (key, keyPath) {

    },
    handleClose (key, keyPath) {

    }
  },
  computed: {
    ...mapGetters([
      'user'
    ])
  }
}
</script>

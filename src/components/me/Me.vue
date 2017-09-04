<template>
  <div class="config-wrap">
    <transition name="el-zoom-in-top">
      <el-menu :default-active="meState" class="el-menu-vertical-demo config-wrap-tab" :collapse="collapse" router>
        <el-submenu class="collapse-nav" index="/me">
          <template slot="title">
            <icon class="wrap-nav-icon" name="clipboard"></icon>
            <span slot="title">课程</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="/me/courseing">在学课程</el-menu-item>
            <el-menu-item index="/me/coursedone">学习历史</el-menu-item>
          </el-menu-item-group>
        </el-submenu>

        <el-submenu class="collapse-nav" index="/me/homework">
          <template slot="title">
            <icon class="wrap-nav-icon" name="edit"></icon>
            <span slot="title">作业</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="/me/homeworking">未完成作业</el-menu-item>
            <el-menu-item index="/me/homeworkdone">已完成作业</el-menu-item>
          </el-menu-item-group>
        </el-submenu>

        <el-menu-item class="wrap-nav" index="/me/note">
          <icon class="wrap-nav-icon" name="book"></icon>
          <span slot="title">笔记</span>
        </el-menu-item>

        <el-menu-item class="wrap-nav" index="/me/plan">
          <icon class="wrap-nav-icon" name="calendar-check-o"></icon>
          <span slot="title">学习计划</span>
        </el-menu-item>

      </el-menu>
    </transition>

    <router-view class="config-wrap-view"></router-view>
  </div>
</template>

<style scoped>
  .wrap-nav {
    display: flex;
    align-items: center;
  }

  .wrap-nav-icon {
    margin-right: 6px;
  }

  .collapse-nav {
    text-align: left;
  }

  .no-border {
    border: none;
    display: block;
    text-align: left;
    box-shadow: 0px 0px 0px #FFFFFF;
  }

  .hint {
    display: block;
    margin: 12px;
    color: #B8B8B8;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import 'vue-awesome/icons/clipboard'
import 'vue-awesome/icons/book'
import 'vue-awesome/icons/edit'
import 'vue-awesome/icons/calendar-check-o'
import 'vue-awesome/icons/address-book'

export default {
  name: 'Me',
  data () {
    return {
      collapse: false
    }
  },
  created () {
    this.$store.commit(types.UPDATE_HEADER_SELECTED, '/me')
    this.$router.replace(this.meState)
  },
  beforeRouteUpdate (to, from, next) {
    this.$store.commit(types.UPDATE_ME_MESTATE, to.path)
    next()
  },
  methods: {
    handleOpen (key, keyPath) {
      console.log(key, keyPath)
    },
    handleClose (key, keyPath) {
      console.log(key, keyPath)
    }
  },
  computed: {
    ...mapGetters([
      'meState',
    ])
  }
}
</script>
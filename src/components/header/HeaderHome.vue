<template>
  <div class="header">
    <el-menu theme="dark" :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
      
      <el-submenu index="1">
        <template slot="title">论坛</template>
        <el-menu-item index="1-1">
          <router-link class="header-link" to="/forum">资讯</router-link>
        </el-menu-item>
        <el-menu-item index="1-2">
          <router-link class="header-link" to="/forum">讨论</router-link>
        </el-menu-item>
      </el-submenu>
      
      <el-submenu index="2">
        <template slot="title">教师</template>
        <el-menu-item index="2-1">
          <router-link class="header-link" to="/forum">语文</router-link>
        </el-menu-item>
        <el-menu-item index="2-2">
          <router-link class="header-link" to="/forum">数学</router-link>
        </el-menu-item>
        <el-menu-item index="2-3">
          <router-link class="header-link" to="/forum">英语</router-link>
        </el-menu-item>
        <el-menu-item index="2-4">
          <router-link class="header-link" to="/forum">物理</router-link>
        </el-menu-item>
        <el-menu-item index="2-5">
          <router-link class="header-link" to="/forum">化学</router-link>
        </el-menu-item>
        <el-menu-item index="2-6">
          <router-link class="header-link" to="/forum">生物</router-link>
        </el-menu-item>
        <el-menu-item index="2-7">
          <router-link class="header-link" to="/forum">政治</router-link>
        </el-menu-item>
        <el-menu-item index="2-8">
          <router-link class="header-link" to="/forum">历史</router-link>
        </el-menu-item>
        <el-menu-item index="2-9">
          <router-link class="header-link" to="/forum">地理</router-link>
        </el-menu-item>
      </el-submenu>

      <el-submenu index="3">
        <template slot="title">课程</template>
        <el-menu-item index="3-1">
          <router-link class="header-link" to="/course">微课程</router-link>
        </el-menu-item>
        <el-menu-item index="3-2">
          <router-link class="header-link" to="/course">直播课</router-link>
        </el-menu-item>
      </el-submenu>

    </el-menu>
  </div>
</template>

<style scoped>
  .header {
    width: 100%;
  }

  .header-link {
    text-decoration: none;
  }
</style>

<script>
export default {
  name: 'HeaderHome',
  data () {
    return {
      activeIndex: '1'
    }
  },
  created () {
    console.log('Header created')
  },
  methods: {
    handleSelect () {

    }
  }
}
</script>

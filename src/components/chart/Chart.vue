<template>
  <div class="config-wrap wrap">
    <el-dropdown class="wrap-menu" type="primary" @command="handleSelect">
      <span class="el-dropdown-link">
        选择项目
        <i class="el-icon-caret-bottom el-icon--right"></i>
      </span>
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item command="course">课程</el-dropdown-item>
        <el-dropdown-item command="note">笔记</el-dropdown-item>
        <el-dropdown-item command="homework">作业</el-dropdown-item>
        <el-dropdown-item command="plan">学习计划</el-dropdown-item>
        <el-dropdown-item command="friend" divided>好友</el-dropdown-item>
        <el-dropdown-item command="chat">聊天</el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
    <router-view></router-view>

  </div>
</template>

<style scoped>
.myCanvas {
  height: 100%;
  width: 100%;
}

.wrap {
  text-align: left;
}

.wrap-menu {
  margin: 4px 0 4px 8px;
  height: fit-content;
}
</style>

<script>
export default {
  name: 'Chart',
  methods: {
    handleSelect(value) {
      switch (value) {
        case 'course':
          this.$router.push('/chart/course')
          break;
        default:
          break;
      }
    }
  }
}
</script>

<template>
  <div class="config-wrap">
    <transition name="el-zoom-in-top">
      <el-menu :default-active="getIndex" class="el-menu-vertical-demo config-wrap-tab" @select="handleSelect">
        <el-menu-item index="1">语文</el-menu-item>
        <el-menu-item index="2">数学</el-menu-item>
        <el-menu-item index="3">英语</el-menu-item>
        <el-menu-item index="4">物理</el-menu-item>
        <el-menu-item index="5">化学</el-menu-item>
        <el-menu-item index="6">生物</el-menu-item>
        <el-menu-item index="7">政治</el-menu-item>
        <el-menu-item index="8">历史</el-menu-item>
        <el-menu-item index="9">地理</el-menu-item>
      </el-menu>
    </transition>
    <div class="config-wrap-view" :class="{ 'no-border':!getLength }">
      <span class="hint" v-if="!getLength">暂无老师加入，请耐心等候</span>
      <teacher-rol v-for="items in getChunkTeachers" :key="items[0].id" :items="items"></teacher-rol>
    </div>
  </div>
</template>

<style scoped>
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
import types from '@/store/types'
import { mapGetters } from 'vuex'
import Logo from '@/assets/logo.png'
import TeacherRol from './TeacherRol'

export default {
  name: 'Teacher',
  components: {
    TeacherRol
  },
  created () {
    this.$store.commit(types.UPDATE_HEADER_SELECTED, '/teacher')
    if (this.teachers.length < 1 && !this.configNet) {
      this.fetchTeacher()
    }
  },
  methods: {
    handleSelect (index) {
      this.$store.commit(types.UPDATE_TEACHER_TEACHERMARK, parseInt(index))
    },
    fetchTeacher () {
      const params = new URLSearchParams()

      params.append('submark', this.teachermark)
      params.append('index', this.getLength)

      this.$common.http.post(this.$common.api.TeacherList, params)
        .then(response => {
          this.$store.commit(types.ADD_TEACHER_CHINA, response.data)
        })
        .catch(error => {
        })
    },
  },
  computed: {
    ...mapGetters([
      'teachers',
      'teachermark',
      'configNet'
    ]),
    getChunkTeachers () {
      const chunkArr = [],
        rols = 3,
        data = this.teachers.filter(item => item.submark == this.teachermark)

      for (let i = 0; i < data.length; i += rols) {
        const tempArr = []
        for (let j = 0; j < rols && (i+j)<data.length; j++) {
          tempArr.push(data[i + j])
        }
        chunkArr.push(tempArr)
      }

      return chunkArr
    },
    getIndex () {
      return '' + this.teachermark
    },
    getLength () {
      return this.teachers.filter(item => item.submark == this.teachermark).length
    }
  }
}
</script>

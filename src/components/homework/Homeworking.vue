<template>
  <div>
    <header class="header">
      <el-checkbox v-model="selectall" @change="handleChange">全选</el-checkbox>
      <el-button class="header-delete" type="primary" size="small" :disabled="!homeworkSelected.length" @click="handleDeleteSelected">清空所选</el-button>
    </header>
    <homework-item v-for="item in homeworkUndone" :key="item.id" :item="item"></homework-item>
  </div>
</template>

<style scoped>
  .header {
    display: flex;
    flex-direction: row-reverse;
    margin: 4px 0;
    padding: 4px 8px 8px 8px;
    border-bottom: .5px solid #BDBDBD;
  }

   .header-delete {
    margin: 0 12px 0 0;
    padding: 4px 12px;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import HomeworkItem from './HomeworkItem'

export default {
  name: 'Homeworking',
  components: {
    HomeworkItem
  },
  data () {
    return {
      selectall: false,
      noneSelect: true
    }
  },
  created () {
    this.$store.commit(types.UPDATE_HOMEWORK_ISDONE, false)
    if (!this.undonecalled) {
      this.fetchHomework()
    }
  },
  beforeDestroy () {
    this.$store.commit(types.HOMEWORK_SELECT_NONE)
  },
  methods: {
    handleChange (event) {
      if (event.target.checked) {
        this.$store.commit(types.HOMEWORK_SELECT_ALL, true)
      } else {
        this.$store.commit(types.HOMEWORK_SELECT_NONE)
      }
    },
    handleDeleteSelected () {
      this.$confirm('此操作将会清空所有选中的题目的答案,是否清空?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.homeworkSelected.forEach(item => {
          this.$store.commit(types.DELETE_HOMEWORK_HOMEWORK, {
            mark: true,
            id: item
          })
        });

        this.$message({
          type: 'success',
          message: '该答案已清空!'
        })
      }).catch(() => {
      })
    },
    fetchHomework () {
      let params = new URLSearchParams()

      // isfinish为 2 表示未完成的作业
      params.append('isfinish', 2)
      params.append('index', this.homeworkUndone.length)
      params.append('studentid', this.user.userid)

      this.$common.http.post(this.$common.api.HomeworkList, params)
        .then(response => {
          this.$store.commit(types.UPDATE_HOMEWORK_UNDONECALLED, true)
          this.$store.commit(types.ADD_HOMEWORK_UNDONE, response.data)
        })
        .catch(error => {
          //以下是测试数据
          let works = [{
            id: 1,
            title: '2用React Natve做一个app',
            content: '',
            uptime: '2014-12-03'
          }, {
            id: 2,
            title: '2用React Natve做一个app',
            content: '',
            uptime: '2014-12-03'
          }, {
            id: 3,
            title: '2用React Natve做一个app',
            content: '',
            uptime: '2014-12-03'
          }]
          this.$store.commit(types.ADD_HOMEWORK_UNDONE, works)
        })
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'homeworkUndone',
      'homeworkSelected',
      'undonecalled'
    ])
  },
  watch: {
    homeworkSelected () {
      this.selectall = this.homeworkSelected.length === this.homeworkUndone.length
    }
  }
}
</script>

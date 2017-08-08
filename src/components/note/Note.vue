<template>
  <div>
    <header class="header">
      <el-checkbox v-model="selectall" @change="handleSelectAll">全选</el-checkbox>
      <el-button class="header-delete" type="primary" size="small" :disabled="!noteSelected.length" @click="handleDeleteSelected">删除所选</el-button>
    </header>
    <note-item v-for="item in notes" :key="item.id" :item="item"></note-item>
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
import NoteItem from './NoteItem'

export default {
  name: 'Note',
  data () {
    return {
      selectall: false
    }
  },
  components: {
    NoteItem
  },
  created () {
    if (this.notes.length === 0) {
      this.fetchNotes()
    }
  },
  methods: {
    handleSelectAll (event) {
      if (this.selectall) {
        this.$store.commit(types.NOTE_SELECT_ALL)
      } else {
        this.$store.commit(types.NOTE_SELECT_NONE)
      }
    },
    handleDeleteSelected () {
      this.$confirm('此操作将会删除所有选中的笔记,是否删除?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.homeworkSelected.forEach(item => {
          this.$store.commit(types.DELETE_NOTE_NOTE, item)
        });

        this.$message({
          type: 'success',
          message: '该答案已清空!'
        })
      }).catch(() => {
      })
    },
    fetchNotes() {
      this.loading = true;
      this.$common.http.get(this.$common.api.StudentNoteList+'?studentid='+this.user.userid+'$index='+this.user.index)
        .then(response => {
          this.loading = false;
          if(this.$common.jsonUtil.jsonLength(response.data)>0) {
            this.$store.commit(types.ADD_NOTE_NOTES, response.data)
          }
          if(this.$common.jsonUtil.jsonLength(response.data) < 10) {
          }
        })
        .catch(error => {
          this.loading = false;
          //测试数据
          let notes = [{
            title: '掌握vue的数组渲染、模板语法、数据绑定、路由管理等基础知识，并尝试实践应用',
            set_time: '2017-04-21',
            id: 3
          }, {
            title: '学习vue跟angularjs的不同',
            set_time: '2017-04-21',
            id: 2
          }, {
            title: '学会用react-native做hybrid开发',
            set_time: '2017-04-21',
            id: 1
          }]
          this.$store.commit(types.ADD_NOTE_NOTES, notes)
        })
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'notes',
      'noteSelected'
    ])
  },
  watch: {
    noteSelected (newVal, oldVal) {
      if (this.notes.length === this.noteSelected.length) {
        this.selectall = true
      } else {
        this.selectall = false
      }
    }
  }
}
</script>
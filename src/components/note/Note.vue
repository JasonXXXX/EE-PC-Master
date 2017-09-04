<template>
  <div>
    <header class="header">
      <el-checkbox v-model="selectall" @change="handleSelectAll">全选</el-checkbox>
      <el-button class="header-delete" type="primary" size="small" :disabled="!noteSelected.length" @click="handleDeleteSelected">删除所选</el-button>
      <el-button class="header-delete" type="primary" size="small" @click="dialogFormVisible = true">新建笔记</el-button>
    </header>
    <!-- <el-button type="text" @click="dialogFormVisible = true">打开嵌套表单的 Dialog</el-button> -->

    <el-dialog title="新建笔记" :visible.sync="dialogFormVisible">
      <el-form :model="form">
        <el-form-item class="add-label" label="标题" :label-width="formLabelWidth">
          <el-input v-model.trim="form.title" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item class="add-label" label="内容" :label-width="formLabelWidth">
          <el-input type="textarea" rows="3" v-model.trim="form.content" auto-complete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="addNote">确 定</el-button>
      </div>
    </el-dialog>
    <note-item v-for="item in getCurrentPageNotes" :key="item.id" :item="item"></note-item>
    <el-pagination layout="prev, pager, next" :total="notes.length" :page-size="pageSize" @current-change="handleCurrentChange"></el-pagination>
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

  .add-label {
    text-align: left;
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
      selectall: false,
      dialogFormVisible: false,
      formLabelWidth: '120px',
      form: {
        title: '',
        content: '',
        settime: ''
      },
      pageSize: 8,
      currentPage: 1
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
    fetchNotes () {
      this.$common.http.get(this.$common.api.StudentNoteList + '?student_id=' + this.user.userid + '&index=' + this.notes.length)
        .then(response => {
          if (this.$common.jsonUtil.jsonLength(response.data) > 0) {
            this.$store.commit(types.ADD_NOTE_NOTES, response.data)
          }
          if (this.$common.jsonUtil.jsonLength(response.data) < 10) {
          }
        })
        .catch(error => {
        })
    },
    addNote () {
      this.form.settime = new Date().getDate().toString()

      const params = new URLSearchParams()

      params.append('operate', 1)
      params.append('note_id', '')
      params.append('note_title', this.form.title)
      params.append('note_content', this.form.content)
      params.append('note_set_time', this.form.settime)
      params.append('note_student_id', this.user.userid)

      this.$common.http.post(this.$common.api.StudentNoteUpdate, params)
        .then(response => {
          if (!(response.data.result === 'false')) {
            this.$store.commit(types.UPDATE_ADD_NOTE, {
              note_id: response.data.note_id,
              note_title: this.form.title,
              note_content: this.form.content,
              note_set_time: this.form.settime,
            })

            this.$message({
              type: 'success',
              message: '已添加!'
            })
          } else {
            this.$message({
              type: 'error',
              message: '添加失败,请重新添加!'
            })
          }
        }).catch(error => {
        })
    },
    handleCurrentChange (page) {
      this.currentPage = page
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
    },
    getCurrentPageNotes () {
      return (this.pageSize * (this.currentPage - 1) + this.pageSize) < this.notes.length ? this.notes.slice(this.pageSize * (this.currentPage - 1), this.pageSize * (this.currentPage - 1) + this.pageSize) : this.notes.slice(this.pageSize * (this.currentPage - 1))
    }
  }
}
</script>
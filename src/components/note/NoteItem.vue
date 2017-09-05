<template>
  <transition name="el-zoom-in-top">
    <div :class="['div', {highlight:edit}]">
      <div class="wrap">
        <div class="wrap-ctrl">
          <i class="el-icon-edit wrap-ctrl-icon" v-if="!edit" @click="handleEdit"></i>
          <i class="el-icon-close wrap-ctrl-icon" v-if="edit" @click="handleClose"></i>
          <i class="el-icon-check wrap-ctrl-icon" v-if="edit" @click="handleSave"></i>
          <i class="el-icon-delete wrap-ctrl-icon" @click="hadnleDelete"></i>
          <el-checkbox class="ctrl-check" v-model="checked" @change="handleChange"></el-checkbox>
        </div>
        <p class="wrap-p" v-if="!edit">{{note || '默认标题'}}</p>
      </div>
      <div class="wrap-input-div" v-if="edit">
        <input class="wrap-input" v-model.trim="note" :maxlength="$common.wordCountLimit.notetitle">
        <span class="note-hint">{{note.length}}/{{$common.wordCountLimit.notetitle}}</span>
      </div>
      <textarea class="note-ta" v-if="edit" v-model.trim="content" placeholder="输入笔记内容" :maxlength="$common.wordCountLimit.notecontent"></textarea>
      <span class="note-hint" v-if="edit">{{content.length}}/{{$common.wordCountLimit.notecontent}}</span>
    </div>
  </transition>
</template>

<style scoped>
.div {
  padding: 8px;
  text-align: left;
  border-bottom: .5px solid #BDBDBD;
  transition: all .8s ease;
}

.div:hover {
  box-shadow: 1px 1px 16px #BDBDBD;
}

.wrap {
  display: flex;
  flex-direction: row-reverse;
  align-items: center;
}

.wrap-p {
  flex: 1;
  margin-right: 12px;
  white-space: nowrap;
  text-overflow: ellipsis;
  text-align: left;
}

.wrap-input-div {
  display: flex;
  align-items: center;
  padding: 8px;
  margin: 0;
  border-bottom: .5px solid #BDBDBD;
}

.wrap-input {
  flex: 1;
  font-size: 15px;
  margin-right: 6px;
  color: #3454BB;
  outline: none;
  border: none;
}

.wrap-content {
  flex-grow: 1;
  text-align: left;
}

.content-problem {
  display: block;
  margin: 4px 0;
  padding: 0;
  color: #424242;
  font-size: 17px;
  text-overflow: ellipsis;
}

.content-time {
  color: #A9A9A9;
  font-size: 13px;
}

.wrap-ctrl {
  display: flex;
  align-items: flex-start;
}

.wrap-ctrl-icon {
  margin: 0 8px;
  padding: 2px;
  color: #989898;
  transition: all .6s ease;
}

.wrap-ctrl-icon:hover,
.wrap-ctrl-icon:active {
  color: #2155dC;
  border-bottom: .5px solid #999999;
}

.ctrl-check {
  margin: 0 0 0 8px;
}

.answer {
  text-align: left;
}

.highlight {
  margin: 4px 2px;
  /* border: .5px solid #2155dC; */
  box-shadow: 2px 2px 16px #999999;
}

.note-ta {
  padding: 12px 8px;
  width: 100%;
  line-height: 24px;
  font-size: 15px;
  color: #747474;
  outline: none;
  border: none;
}

.note-hint {
  font-size: 12px;
  color: #898989;
}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'

export default {
  name: 'NoteItem',
  props: ['item'],
  data() {
    return {
      checked: false,
      note: this.item.note_title,
      content: this.item.note_content || '',
      edit: false
    }
  },
  methods: {
    handleChange(event) {
      if (event.target.checked) {
        this.$store.commit(types.ADD_NOTE_SELECTED, this.item.note_id)
      } else {
        this.$store.commit(types.DELETE_NOTE_SELECTED, this.item.note_id)
      }
    },
    handleEdit() {
      this.edit = true
    },
    handleClose() {
      this.edit = false
    },
    handleSave() {
      this.$confirm('确定更新笔记?', '确认', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'confirm'
      }).then(() => {
        const params = new URLSearchParams()

        params.append('operate', 3)
        params.append('note_id', this.item.note_id)
        params.append('note_title', this.note)
        params.append('note_content', this.content)

        this.$common.http.post(this.$common.api.StudentNoteUpdate, params)
          .then(response => {
            if (response.data) {
              //返回不为0，则为成功后的id
              let data = {
                id: this.item.note_id,
                title: this.note,
                content: this.content,
                set_time: this.$common.timeUtil.getDate()
              }
              this.$store.commit(types.UPDATE_NOTE_NOTES, data)
              this.$message({
                type: 'success',
                message: '笔记已保存!'
              })
            } else {
              this.$message({
                type: 'error',
                message: '保存失败,请重新保存!'
              })
            }
          }).catch(error => {
          })
      }).catch(() => {
      })
    },
    hadnleDelete() {
      this.$confirm('确定删除该笔记?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const params = new URLSearchParams()

        params.append('operate', 2)
        params.append('note_id', this.item.note_id)

        this.$common.http.post(this.$common.api.StudentNoteUpdate, params)
          .then(response => {
            if (response.data) {
              this.$store.commit(types.DELETE_NOTE_NOTE, this.item.note_id)

              this.$message({
                type: 'success',
                message: '笔记已删除!'
              })
            } else {
              this.$message({
                type: 'error',
                message: '删除失败,请重新删除!'
              })
            }
          }).catch(error => {
          })
      }).catch(() => {
      })
    }
  },
  computed: {
    ...mapGetters([
      'noteSelected'
    ])
  },
  watch: {
    noteSelected() {
      if (this.noteSelected.length > 0) {
        this.noteSelected.every(item => {
          this.checked = item === this.item.note_id
          return !this.checked
        })
      } else {
        this.checked = false
      }
    },
    'item.note_title': {
      handler(newVal, oldVal) {
        this.note = newVal
        if (newVal == '') {
          this.checked = false
        }
      },
      deep: true
    }
  }
}
</script>

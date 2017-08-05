<template>
  <div class="note-div">
    <div class="title">
      <router-link class="router-link" to="/note"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
      <span class="center">我的笔记</span>
      <transition name="fade">
        <span class="glyphicon glyphicon-saved" aria-hidden="true" @click="save" v-if="mark"></span>
      </transition>
    </div>
    <div class="note-content">
      <p class="note-content-time">{{set_time}}</p>
      <input class="note-content-title" placeholder="标题" v-model.lazy.trim="title" @change="change"/>
      <textarea class="note-content-content" placeholder="你的笔记..." v-model.lazy.trim="content" @change="change"></textarea>
    </div>
  </div>
</template>

<style scoped>
.note-div {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100vh;
}

.note-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 0;
  margin: 0;
  width: 100%;
}

.note-content-time {
  width: 100%;
  padding: .4rem .8rem;
  margin: 5rem 0 0 0;
  color: #999999;
  font-size: 12px;
}

.note-content-title {
  width: 100%;
  border: none;
  border-bottom: .5px solid #BBB;
  outline: none;
  padding: .4rem .8rem;
  margin: 0;
  font-size: 17px;
  white-space: nowrap;
  color: #73D0AB;
}

.note-content-content {
  flex: 1;
  padding: .8rem;
  margin: 0;
  font-size: 15px;
  border: none;
  outline: none;
}
</style>

<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'
import { Toast, MessageBox } from 'mint-ui'

export default {
  name: 'NoteDetail',
  data() {
    return {
      id: 0,
      title: '',
      content: '',
      set_time: '',
      mark: false
    }
  },
  mounted() {
    this.id = this.getNote.id
    this.title = this.getNote.title
    this.set_time = this.getNote.set_time
    this.content = this.getNote.content
  },
  beforeRouteLeave (to, from, next) {
    if (this.mark) {
      MessageBox.confirm('返回将丢失修改的内容。是否返回？').then(action => {
        next()
      }).catch( cancle => {
        next(false)
      })
    } else {
      next()
    }
  },
  methods: {
    save() {
      let params = new URLSearchParams()
      params.append('note_id', this.id || '')
      params.append('note_title', this.title)
      params.append('note_content', this.content)
      this.$common.http.post(this.$common.api.StudentNoteUpdate, params)
        .then(response => {
          if (0 !== response.data.result) {
            //返回不为0，则为成功后的id
            let data = {
              id: response.data.result,
              title: this.title,
              content: this.content,
              set_time: this.$common.timeUtil.getDate()
            };
            Toast({
              message: '笔记已保存',
              position: 'bottom',
              duration: 2000,
            })
            this.$store.commit(types.UPDATE_NOTE_NOTES, { note: data })
            this.$router.go(-1)
          } else {
            Toast({
              message: '保存失败！请重新保存',
              position: 'bottom',
              duration: 2000,
            })
          }
        }).catch(error => {
        })
    },
    change() {
      this.mark = true;
    }
  },
  computed: {
    ...mapGetters({
      getNote: 'note'
    })
  }
}
</script>
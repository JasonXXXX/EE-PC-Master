<template>
  <div class="note-div">
    <div class="title">
      <span class="glyphicon glyphicon-menu-left" aria-hidden="true" @click="goBack"></span>
      <span class="center">添加笔记</span>
      <transition name="fade">
        <span class="glyphicon glyphicon-saved" aria-hidden="true" @click="save" v-if="mark"></span>
      </transition>
    </div>
    <div class="note-content">
      <p class="note-content-time">{{set_time}}</p>
      <input class="note-content-title" placeholder="标题" v-model.lazy.trim="title"/>
      <textarea class="note-content-content" placeholder="你的笔记..." v-model.lazy.trim="content"></textarea>
    </div>
  </div>
</template>

<style lang="css" scoped>
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
  color: #33B0AB;
  font-size: 12px;
}

.note-content-title {
  width: 100%;
  border: none;
  border-bottom: .5px solid #BBB;
  outline: none;
  padding: .4rem .8rem;
  margin: 0;
  font-size: 15px;
  overflow-x: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  color: #73D0AB;
}

.note-content-content {
  flex: 1;
  padding: .8rem;
  margin: 0;
  font-size: 14px;
  border: none;
  outline: none;
}
</style>

<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'
import { Toast, MessageBox } from 'mint-ui'

export default {
  name: 'NoteAdd',
  data() {
    return {
      set_time: 'xxxx-xx-xx xx:xx',
      title: '',
      content: '',
      mark: false
    }
  },
  mounted() {
    if(!this.draft.title && !this.draft.content) {
      this.set_time = this.$common.timeUtil.getTime()
    } else {
      this.set_time = this.draft.set_time
      this.title = this.draft.title
      this.content = this.draft.content
    }
  },
  methods: {
    goBack() {
      if (this.mark) {
        MessageBox.confirm('返回将丢失修改的内容。是否返回？').then(action => {
          this.$router.go(-1)
        })
      } else {
        this.$router.go(-1)
      }
    },
    save() {
      let params = new URLSearchParams()
      params.append('note_id', '')
      params.append('note_title', this.title)
      params.append('note_content', this.content)
      this.$common.http.post(this.$common.api.StudentNoteUpdate, params)
        .then(response => {
          if (0 !== response.data.result) {
            //返回不为0，则为成功后的id
            let data = {
              note_id: response.data.result,
              title: this.title,
              content: this.content,
              set_time: Timer.getDate()
            };
            this.$store.commit(types.UPDATE_ADD_NOTE, {note: data})
            this.$router.go(-1)
          } else {
            MessageBox.confirm('保存失败，是否存入草稿？').then(action => {
              //保存到本地

              //在内存中保存草稿
              let data = {
                title: this.title,
                content: this.content,
                set_time: this.$common.timeUtil.getDate()
              };
              this.$store.commit(types.UPDATE_NOTE_DRAFT, {draft: data})
              Toast({
                message: '草稿已保存',
                position: 'bottom',
                duration: 2000
              })
              this.$router.go(-1)
            }).catch(cancle => {
              
            })
          }
        }).catch(error => {
          //测试
          MessageBox.confirm('网络发生错误，是否存入草稿？').then(action => {
            //保存到本地

            //在内存中保存草稿
            let data = {
              title: this.title,
              content: this.content,
              set_time: this.$common.timeUtil.getDate()
            }
            this.$store.commit(types.UPDATE_NOTE_DRAFT, {draft: data})
            Toast({
              message: '草稿已保存',
              position: 'bottom',
              duration: 2000
            })
            this.$router.go(-1)
          })
        })
    }
  },
  watch: {
    title() {
      this.mark = true;
    },
    content() {
      this.mark = true;
    }
  },
  computed: {
    ...mapGetters([
      'draft'
    ])
  }
}
</script>
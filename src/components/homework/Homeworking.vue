<template>
  <div>
    <header class="header" v-if="getHomeworkUndone.length">
      <el-checkbox v-model="selectall" @change="handleChange">{{$common.strings.homework_select_all}}</el-checkbox>
      <el-button class="header-delete" type="primary" size="small" :disabled="!homeworkSelected.length" @click="handleDeleteSelected">{{$common.strings.homework_clear_all}}</el-button>
    </header>
    <homework-item v-for="item in getHomeworkUndone" :key="item.id" :item="item"></homework-item>
    <span class="config-no-list-hint" v-if="!getHomeworkUndone.length">{{$common.strings.no_homework_hint}}</span>
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
  data() {
    return {
      selectall: false,
      noneSelect: true
    }
  },
  created() {
    this.$store.commit(types.UPDATE_HOMEWORK_ISDONE, false)
    if (this.homeworkDone.length === 0) {
      this.fetchHomework()
    }
  },
  beforeDestroy() {
    this.$store.commit(types.HOMEWORK_SELECT_NONE)
  },
  methods: {
    handleChange(event) {
      if (event.target.checked) {
        this.$store.commit(types.HOMEWORK_SELECT_ALL, true)
      } else {
        this.$store.commit(types.HOMEWORK_SELECT_NONE)
      }
    },
    handleDeleteSelected() {
      this.$confirm($common.strings.homework_confirm_clear_all, $common.strings.dialog_warning_type, {
        confirmButtonText: $common.strings.dialog_button_yes,
        cancelButtonText: $common.strings.dialog_button_no,
        type: 'warning'
      }).then(() => {
        this.homeworkSelected.forEach(item => {
          this.$store.commit(types.DELETE_HOMEWORK_HOMEWORK, {
            mark: true,
            id: item
          })
        })

        this.$message({
          type: 'success',
          message: $common.strings.homework_after_clear
        })
      }).catch(() => {

      })
    },
    fetchHomework() {
      let params = new URLSearchParams()

      params.append('isfinish', 2)
      params.append('index', this.homeworkDone.length)
      params.append('student_id', this.user.userid)

      this.$common.http.post(this.$common.api.HomeworkList, params)
        .then(response => {
          // this.$store.commit(types.UPDATE_HOMEWORK_UNDONECALLED, true)
          this.$store.commit(types.ADD_HOMEWORK_DONE, response.data)
        })
        .catch(error => {
        })
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'homeworkDone',
      'homeworkSelected',
    ]),
    getHomeworkUndone() {
      return this.homeworkDone.filter(item => !item.work_anser.length)
    }
  },
  watch: {
    homeworkSelected() {
      this.selectall = this.homeworkSelected.length === this.homeworkDone.length
    }
  }
}
</script>

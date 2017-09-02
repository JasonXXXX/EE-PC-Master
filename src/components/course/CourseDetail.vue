<template>
  <div class="config-wrap wrap-player">
    <div class="wrap-collapse" @click="handleBack">
      <i class="el-icon-arrow-left"></i>
      <span>{{$common.strings.course_collapse}}</span>
    </div>
    <video-player :video="video"></video-player>
    <div class="course-info">
      <h3>{{course.course_content}}</h3>
      <p>
        <span class="wrap-info-addtive" v-if="course.course_mark===1 || course.course_mark===2">{{$common.strings.cbroom_course_teacher}}: {{course.teacher_name}}</span>
        <span class="wrap-info-addtive" v-if="course.course_mark===1">{{$common.strings.cbroom_course_duration}}: {{course.duration || '未知'}}</span>
        <span class="wrap-info-addtive" v-if="course.course_mark===2">{{$common.strings.cbroom_course_fee}}:
          <span class="info-fee">&yen;{{course.fee || '未定'}}</span>
        </span>
      </p>
    </div>
  </div>
</template>

<style>
  .wrap-player {
    flex-direction: column;
    padding: 8px;
    width: 100%;
    height: auto;
  }

  .wrap-collapse {
    display: flex;
    align-items: center;
    padding: 8px 16px;
    margin: 4px 0;
    width: fit-content;
    color: #DDDDDD;
    border-bottom: 1px solid transparent;
    transition: all .6s ease;
  }

  .wrap-collapse:hover {
    color: #424242;
    border-bottom: 1px solid #BDBDBD;
  }

  .wrap-info-addtive {
    display: inline-block;
    padding: 0;
    margin: 0 8px 0 0;
    color: #989898;
    font-size: 14px;
  }

  .info-fee {
    color: #4276FF;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import VideoPlayer from './VideoPlayer'
import Storage from '@/common/util/storage'

export default {
  name: 'CourseDetail',
  data () {
    return {
      video: {
        src: 'http://localhost:8080/TestServer/video.mp4',
        id: this.course.course_id,
        text: this.course.course_content
      }
    }
  },
  components: {
    VideoPlayer
  },
  create () {
  },
  methods: {
    playHappened () {

    },
    handleBack () {
      this.$router.back()
    }
  },
  computed: {
    ...mapGetters([
      'course'
    ])
  }
}
</script>

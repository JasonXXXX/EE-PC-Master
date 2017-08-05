<template>
    <div>
      <div class="title">
        <router-link class="router-link" to="/cbroom"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
        <span>{{$route.params.content}}</span>
      </div>
      <div class="video-content">
        <img v-lazy="this.detail.cource_image"/> 
        <p class="course-title">{{this.detail.content}}</p>
        <p class="course-teacher">&emsp;&emsp;{{this.detail.teachername}}</p>
        <p><span style="font-size: 15px">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;评论列表:&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span>
        <a href="#go"><span class="glyphicon glyphicon-edit fr" ></span></a>
        </p>
      </div>
      <p v-if="detail.evaluations.length==0">暂无评论，我来发表第一篇评论！</p>
      <div v-else class="comments_content">
        <div style="height: 449px;width: 100%">
        </div>
        <div class="bottom-line" v-for="evaluations in detail.evaluations" >
          <p>&emsp;&emsp;{{evaluations.content}}</p>
          <p>&emsp;&emsp;评分：{{evaluations.evaluation}}</p>
        </div>
      </div>
      <!-- 评论框 -->
      <div class="commentBox">
        <h3 id="go">发表评论</h3>
        <textarea name="" value="请填写评论内容" v-model="commentText"></textarea>
        <button @click="addComment">发表</button>
        <button @click="canelComment" class="fr">取消</button>
     </div>
    </div>
</template>

<style scoped>
.video-content {
  position: fixed;
  width:100%; 
  height: 400px;
  z-index: 3;
  background-color:white;
  top: 50px;
  left: 0;
  float: left;
}
.bottom-line {
    border-bottom: 1px solid #434343;
    margin-bottom: 5px;
  }
comments_content {
  top: 350px;
  float: left;
}
.course-title {
  margin: 0 0 1rem 0;
  font-size: 16px;
  background-color:white;
}
.course-teacher {
  display: flex;
  align-items: center;
  padding: 0;
  margin: 0;
  font-size: 13px;
  background-color:white;
}
.course-teacher-span {
  flex-grow: 1;
}
.course-list-div .glyphicon {
  float: right;
  right: 8px;
  margin-bottom: 4px;
  line-height: 60px;
}
  .commentBox {
    margin:20px;
  }
  .commentBox h3 {
    color: #634322;
    background: #e9e5df;
    padding: 8px 15px;
    text-align: left;
    font-size: 16px;
  }
  .commentBox textarea {
    overflow: auto;
    width: 100%;
    height: 95px;
    outline: none;
    resize: none;
  }
  .commentBox button {
    padding: 5px 30px;
    background: #434343;
    border-radius: 5px;
    color: #fff;
    font-size: 16px;
  }
  .commentBox button:hover {
    color:#fff;
    background: #333333;
  }
</style>

<script>
import router from '@/router/index'
import Be from '@/assets/be.jpg'
import { mapGetters } from 'vuex'

export default {
  data() {
    return {
      detail: {
        evaluations: [],
        content: '',
        cource_id: 0,
        teachername: '',
        cource_video: '',
        cource_image: ''
      },
      commentText: '',
    }
  },
  mounted() {
    this.fetchmicrolectureDetail()
  },
  methods: {
    addComment(){
      if (this.commentText!==''){
        this.detail.evaluations.push({
          content: this.commentText,
          id: 1
        })
        this.commentText = ''
      }
    },
    canelComment(){
      this.commentText = ''
    },
    fetchmicrolectureDetail() {
      let params = new URLSearchParams()
      params.append('course_id', this.$route.params.courseid)

      this.$common.http.get(this.$common.api.MicrocourseInfo, params)
        .then(response => {
          this.detail.evaluations = response.data.evaluations
          this.detail.content = response.data.content
          this.detail.cource_id = response.data.cource_id
          this.detail.teachername = response.data.teachername
          this.detail.cource_video = response.data.cource_video
          this.detail.cource_image = response.data.cource_image
        })
        .catch(error => {
          //测试数据
          let microlectureDetail = {
              evaluations: [{
                content: "课程内容充实,学习到很多知识",
                evaluation: 4,
                id: 1
              },
              {
                content: "课程内容充实,学习到很多知识",
                evaluation: 4,
                id: 2
              },
              {
                content: "课程内容充实,学习到很多知识",
                evaluation: 4,
                id: 3
              },
              {
                content: "课程内容充实,学习到很多知识",
                evaluation: 4,
                id: 4
              },
              {
                content: "课程内容充实,学习到很多知识",
                evaluation: 4,
                id: 5
              }],
              content: '掌握be动词的用法',
              cource_id: 1,
              teachername: 'jason',
              //cource_video: Video,
              cource_image: Be
            }
          this.detail.content = microlectureDetail.content
          this.detail.cource_id = microlectureDetail.cource_id
          this.detail.teachername = microlectureDetail.teachername
          this.detail.cource_video = microlectureDetail.cource_video
          this.detail.cource_image = microlectureDetail.cource_image
          this.detail.evaluations = microlectureDetail.evaluations
          });
  }
},
computed: {
    ...mapGetters([
      'user'
    ])
  }
}
</script>
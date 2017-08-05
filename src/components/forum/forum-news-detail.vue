<template>
  <transition name="fade">
    <div style="margin-left: 10px;margin-right:10px">
      <div class="title">
        <router-link class="router-link" to="/home/forum/forum-news">
          <span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>
        </router-link>
        <span>{{$route.params.newstitle}}</span>
      </div>
<!-- 详细内容 -->
      <div class="bottom-line">
        <h3  style="text-align:center">{{detail.title}}</h3>  
        <p><span class="glyphicon glyphicon-user" style="text-align: center;width: 60%;">{{detail.sender_name}}</span>
          <span class="subtitle">{{detail.send_time}}</span>
        </p>
        <p>&emsp;&emsp;{{detail.content}}</p>
        <p align="right" class="glyphicon" @click="toggleFavorite(detail)" :class="getFavoriteIcon(detail)" >收藏</p>
      </div>
      <p><span style="font-size: 22px">评论列表:</span>
         <a href="#go"><span class="glyphicon glyphicon-edit fr" ></span></a>
      </p>
      <p v-if="detail.comment_views.length==0">暂无评论，我来发表第一篇评论！</p>
      <div v-else class="bottom-line" v-for="comments in detail.comment_views" >
        <p>&emsp;&emsp;{{comments.content}}</p>
        <p><span>{{comments.send_time}}</span>
            <span class="fr">来自:{{comments.sender_id}}</span>
        </p>
      </div>
      <!-- 评论框 -->
      <div class="commentBox">
        <h3 id="go">发表评论</h3>
        <textarea name="" value="请填写评论内容" v-model="commentText"></textarea>
        <button @click="addComment">发表</button>
        <button @click="canelComment" class="fr">取消</button>
     </div>




    </div>
  </transition>
</template>

<script>
import router from '@/router/index'
import types from '@/store/types'
import atypes from '@/store/action-types'
import { mapGetters } from 'vuex'
import Convert from '@/common/util/convert.js'

export default {
  data() {
    return {
      detail: {
        comment_views: [],
        // comment_name: '',
        content: '',
        id: 0,
        mark: 1,
        message_mark: 0,
        send_time: '',
        sender_name: '',
        title: ''
      },
      commentText: ''
    }
  },
  created() {
    this.fetchNewsDetail()
  },
  methods: {
    getMyTime() {
      let now = new Date()
      let year = now.getFullYear()
      let month = now.getMonth() + 1
      let day = now.getDate()
      let today = year + "-" + month + "-" + day
      return today
    },
    addComment(){
      if (this.commentText!==''){
        this.detail.comment_views.push({
          comment_tocomment_id: 1,
          content: this.commentText,
          id: 1,
          send_time: this.getMyTime(),
          sender_id: this.user.userid,
          sender_mark: 2
        })
        this.commentText = ''
      }
    },
    canelComment(){
      this.commentText = ''
    },
    toggleFavorite(detail) {
      if (this.isFavorite(detail)) {
        // this.$context.commit(atypes.DELETE_FAVORITE_LIST, detail)    
        this.$store.dispatch(atypes.DELETE_FAVORITE_LIST, detail)
        // this.deleteFavoriteList(detail)
        console.log(this.favoriteList)
      } else {
        // this.$context.commit(atypes.SAVE_FAVORITE_LIST, detail)
        // this.saveFavoriteList(detail)
        this.$store.dispatch(atypes.SAVE_FAVORITE_LIST, detail)
        console.log(this.favoriteList)
      }
    },
    getFavoriteIcon(detail) {
      if (this.isFavorite(detail)) {
        return 'glyphicon-heart'
      }
      return 'glyphicon-heart-empty'
    },
    isFavorite(detail) {
      const index = this.favoriteList.findIndex((item) => {
        return item.id == detail.id && item.mark == detail.mark
      })
      return index > -1
    },
    fetchNewsDetail() {
      this.$common.http.get(this.$common.api.MessageInfo+'?message_id='+this.$route.params.newsid)
        .then(response => {
          this.detail.comment_views = response.data.comment_views
          this.detail.content = response.data.content
          this.detail.id = response.data.id
          this.detail.mark = response.data.mark
          this.detail.message_mark = response.data.message_mark
          this.detail.send_time = response.data.send_time
          this.detail.sender_name = Convert.convertName(response.data.sender_mark , response.data.sender_id)
          this.detail.title = response.data.title
          // this.detail.comment_name = Convert.convertName(response.data.comment_views.sender_mark , response.data.comment_views.sender_id)
        })
        .catch(error => {
          //测试数据
          let newsDetail = {
            comment_views: [{
              comment_tocomment_id: 1,
              content: "好厉害！瞬间就明白了都，希望作者多多出这样的良心文章!!!坐等更新~",
              id: 1,
              send_time: "2017-04-18",
              sender_id: 1,
              sender_mark: 2
            },{
              comment_tocomment_id: 2,
              content: "新技能get！",
              id: 2,
              send_time: "2017-04-20",
              sender_id: 2,
              sender_mark: 2
            },{
              comment_tocomment_id: 1,
              content: "好厉害！瞬间就明白了都，希望作者多多出这样的良心文章",
              id: 1,
              send_time: "2017-04-18",
              sender_id: 1,
              sender_mark: 2
            },{
              comment_tocomment_id: 2,
              content: "新技能get！",
              id: 2,
              send_time: "2017-04-20",
              sender_id: 2,
              sender_mark: 2
            },{
              comment_tocomment_id: 3,
              content: "见解独到，佩服佩服",
              id: 3,
              send_time: "2017-04-25",
              sender_id: 3,
              sender_mark: 2
            }
            ],
          content: "我们经常需要把某种模式匹配到的所有路由，全都映射到同个组件。例如，我们有一个 User 组件，对于所有 ID 各不相同的用户，都要使用这个组件来渲染。那么，我们可以在 vue-router 的路由路径中使用『动态路径参数』（dynamic segment）来达到这个效果.一个『路径参数』使用冒号 : 标记。当匹配到一个路由时，参数值会被设置到 this.$route.params，可以在每个组件内使用。于是，我们可以更新 User 的模板，输出当前用户的 ID .提醒一下，当使用路由参数时，例如从 /user/foo 导航到 user/bar，原来的组件实例会被复用。因为两个路由都渲染同个组件，比起销毁再创建，复用则显得更加高效。不过，这也意味着组件的生命周期钩子不会再被调用。",
          id: 2,
          mark: 1,
          message_mark: 2,
          send_time: "2017-1-2",
          sender_id: 1,
          sender_mark: 1,
          title: "6660分钟vue快速入门"
        }
          this.detail.comment_views = newsDetail.comment_views
          this.detail.content = newsDetail.content
          this.detail.id = newsDetail.id
          this.detail.mark = newsDetail.mark
          this.detail.message_mark = newsDetail.message_mark
          this.detail.send_time = newsDetail.send_time
          this.detail.sender_name = Convert.convertName(newsDetail.sender_mark , newsDetail.sender_id)
          this.detail.title = newsDetail.title
          // this.detail.comment_name = Convert.convertName(newsDetail.comment_views.sender_mark , newsDetail.comment_views.sender_id)

        });
    },

  },
  computed: {
    ...mapGetters([
      'favoriteList',
      'user'
    ])
  }
}
</script>

<style scoped>
  .bottom-line {
    border-bottom: 1px solid #434343;
    margin-bottom: 5px;
  }
  .subtitle {
    width: 60%;
    text-align: center; 
  }
  .fr{
    float: right;
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
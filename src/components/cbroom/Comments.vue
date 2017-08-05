<template>
  <div class="comment">
    <div class="comments" v-if="commentShow">
      <h3>精彩评论</h3>
      <ul>
        <li v-for="comment in comments">
          <img :src="comment.user.avatarUrl | userCover">
          <div class="cm-container">
            <div class="cm-name">
              <h4 class="pull-left">{{ comment.user.nickname }}</h4>
              <span class="pull-right">{{ comment.time | timeToDate }}</span>
            </div>
            <p class="cm-content">{{ comment.content }}</p>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>

export default {
  name: 'comment',
  props: ['mid'],
  data () {
    return {
      commentShow: false,
      comments: []
    }
  },
  beforeMount() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.comments = []

      let params = new URLSearchParams()
      params.append('id', this.mid)
      this.$common.http.get(this.$common.api.GetMicrocourseInfoServlet, params).then(response => {
        this.comments = response.data.evallist

        if(this.comments.length > 0){
          this.commentShow = true
        }
      }).catch(error => {
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "src/style/base/mixins";

.comments {
  margin: 0 2%;
  padding: .4rem 0;
  h3 {
    font-size: 13px;
    font-weight: normal;
    margin-bottom: .3rem;
  }
  li {
    position: relative;
    padding: .3rem 0 0 .9rem;
    img {
      position: absolute;
      top: .3rem;
      left: 0;
      width: .9rem;
      height: .9rem;
      border-radius: 50%;
    }
    .cm-container {
      margin: 0 2% 0 3%;
    }
    .cm-name {
      overflow: hidden;
      font-size: 12px;
      margin-bottom: .2rem;
      h4 {
        font-weight: normal;
        color: #666;
      }
      span {
        color: #999;
      }
    }
    .cm-content {
      font-size: 13px;
      line-height: 1.6;
      padding-bottom: .3rem;
    }
  }
}
@include dpr-border(cm-content,#e9e9e9,bottom)
</style>

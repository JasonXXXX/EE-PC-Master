<template>
	<div style="width: 100%;">
		<loadmore :top-method="loadTop" :bottom-method="loadBottom" :bottom-all-loaded="allLoaded" ref="loadMore" :auto-fill="autoFill">
			<div class="teacher-item" v-for="ne in getTeachers" @click="showDetail(ne.id, ne.name)" :key="ne.id">
			    <img class="teacher-headimg" :src="ne.headimg">
          <div class="text">
          <h4 class="name">{{ne.name}}</h4>
          <p class="intro">{{ne.intro}}</p>
          </div>
			</div>
		</loadmore>
  </div>
</template>


<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'
import { Toast, Loadmore } from 'mint-ui'
import Logo from '@/assets/logo.png'

export default {
	name: 'china',
	data() {
	  return {
	  	allLoaded: false,
			autoFill: false
	  }
	},
  components: {
    Loadmore
  },
	created() {
	  if(this.teachers.length<1) {
	  	this.fetchTeacher()
	  }
	},
	methods: {
		loadTop() {
      this.fetchTeacher()
    },
    loadBottom() {
      this.fetchTeacher()
    },
    showDetail(id, name) {
      this.$router.push({
        path: '/chinadetail/' + id + '/name/' + name
      })
    },
	  fetchTeacher() {
	  	let params = new URLSearchParams()
      params.append('submark', this.teachermark)
      params.append('index', this.getTeachers.length)
    	this.$common.http.post(this.$common.api.TeacherList, params)
    	  .then(response => {
          if (this.$common.jsonUtil.jsonLength(response.data) < 5) {
            Toast({
              message: '数据已全部加载 :)',
              position: 'bottom',
              duration: 2000
            })
          	this.allLoaded = true
          }
          this.$store.commit(types.ADD_TEACHER_CHINA, response.data)
          this.$refs.loadMore.onTopLoaded()
          this.$refs.loadMore.onBottomLoaded()
        })
    	  .catch(error => {
    	    //测试数据
    	    let china = [
            {
              id: 1,
              headimg: Logo,
              name: '张建新',
              intro: '讲课简单易懂，平易近人。',
              submark: 1
            }, {
              id: 2,
              headimg: Logo,
              name: '胡荣玲',
              intro: '讲课简单易懂，平易近人。',
              submark: 1
            }, {
              id: 5,
              headimg: Logo,
              name: '蔡红',
              intro: '讲课简单易懂，平易近人。',
              submark: 1
            }
          ]
    	    this.$store.commit(types.ADD_TEACHER_CHINA, china)
    	  });
	  },
    chinaDetail(chinaid) {
      this.$router.push('/chinadetail/'+chinaid)
    }
	},
	computed: {
	  ...mapGetters([
      'teachers',
      'teachermark'
    ]),
    getTeachers() {
      /**
       * 改用保存在 vuex 里面的teachermark来记录当前显示的教师，
       * 这样才能触发视图更新
       */
      return this.teachers.filter(item => item.submark==this.teachermark)
    }
	}
}
</script>

<style lang="css" >
.teacher-item {
  display: flex;
  align-items: center;
  padding-top: 10px;
  margin: 0;
  width: 100%;
  border-bottom: .5px solid #BBB;
  overflow-x: hidden;
}

  .teacher-headimg {
  padding: 0;
  margin: 8px;
  width: 60px;
  height: 60px;
  border-radius: 50%;
}

.text {
  display: flex;
  flex-direction: column;
  justify-content: center;
  flex: 1;
  line-height: 20px;
  overflow: hidden;
  font-size: 14px;
}

.name {
  margin-bottom: 10px;
  color: black;
}

.intro {
  color: #999999;
  font-size: 12px;
}

  ul {
    border-bottom: 1px solid black ;
    overflow: hidden;  
    width: 80%;  
    margin: 0 auto;  
    text-align: center;  
  }

  li {
    list-style-type: none;
    display: inline;
    width:33.33%; 
    float: left;
    font-size: 14px;
  }
</style>
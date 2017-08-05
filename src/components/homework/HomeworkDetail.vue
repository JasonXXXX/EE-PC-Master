<template>
	<div class="homework-div">
	  <div class="title">
	    <router-link class="router-link" to="/homework"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
	    <span class="center">我的作业</span>
	    <transition name="fade">
	      <span class="glyphicon glyphicon-saved" aria-hidden="true" @click="saveHomework" v-if="mark"></span>
	    </transition>
	  </div>
	  <header class="header">
	  	<p class="homework-header-course">{{coursetitle}}</p>
	    <p class="homework-header-time">{{getHomework.uptime}}</p>
	  </header>
	  <div class="homework-content">
	    <p class="homework-content-title">{{getHomework.title}}</p>
	    <textarea class="homework-content-content" placeholder="我的答案..." v-model.lazy.trim="content" @change="answerChangeTrigger"></textarea>
	  </div>
	</div>
</template>

<style lang="css" scoped>
.homework-div {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100vh;
}

.header {
	display: flex;
	padding: 8px 4px 8px 8px;
	margin: 5rem 0 0 0;
}

.homework-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 0;
  margin: 0;
  width: 100%;
}

.homework-header-course {
	flex: 1;
	padding: 0;
	margin: 0;
	white-space: nowrap;
	text-overflow: ellipsis;
	font-size: 16px;
	color: #73D0AB;
}

.homework-header-time {
  padding: 0;
  margin: 0;
  white-space: nowrap;
  color: #999999;
  font-size: 12px;
}

.homework-content-title {
  width: 100%;
  border: none;
  border-bottom: .5px solid #BBB;
  outline: none;
  padding: .4rem .8rem;
  margin: 0;
  font-size: 17px;
  white-space: nowrap;
  color: #424242;
}

.homework-content-content {
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
	name: 'HomeworkDetail',
	data() {
		return {
			content: '',
			mark: false,
			coursetitle: '测试数据：这里是课程名称'
		}
	},
	created() {
		this.content = this.getHomework.content
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
		answerChangeTrigger() {
			this.mark = true;
		},
		saveHomework() {
			let params = new URLSearchParams()
			params.append('work_id', this.getHomework.id)
			params.append('work_content', this.getHomework.content)
			this.$common.http.post(this.$common.api.HomeworkUpdate, params).then(response => {
			  if ('true' == response.data.result) {
			  	Toast({
			  	  message: '作业已保存',
			  	  position: 'bottom',
			  	  duration: 2000,
			  	});
			    let data = {
		      	id: this.getHomework.id,
		      	content: this.content,
		      	uptime: this.$common.timeUtil.getDate()
		      };
			    this.$store.commit(types.UPDATE_HOMEWORK_HOMEWORKS, data)
			    this.$router.back()
			  } else {
			  	Toast({
			  	  message: '保存失败!请重新保存',
			  	  position: 'bottom',
			  	  duration: 2000,
			  	});
			  }
			}).catch(error => {
			  //测试结果
  	    let data = {
        	id: this.getHomework.id,
        	content: this.content,
        	uptime: this.$common.timeUtil.getDate()
        };
  	    this.$store.commit(types.UPDATE_HOMEWORK_HOMEWORKS, data)
  	    this.$router.back()
			});
		}
	},
	computed: {
		...mapGetters([
			'getHomework'
		])
	}
}	
</script>
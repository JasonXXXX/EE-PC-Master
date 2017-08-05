<template>
	<div>
		<div class="title">
      <router-link class="router-link" to="/userdetail" replace><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
      <span class="center">编辑头像</span>
      <span class="glyphicon glyphicon-ok" aria-hidden="true" @click.prevent="uploadImg"></span>
    </div>
		<vue-dplayer class="course-player"
    :loop="false"
    :video="video"
		></vue-dplayer>
	</div>
</template>

<style scoped>
	.course-player {
		padding: 0;
		margin: 5rem 0 0 0;
		width: 100%;
		height: auto;
	}
</style>

<script>
import VueDPlayer from 'vue-dplayer'

export default {
	name: 'CoursePlayer',
	data() {
		return {
			video: {
				url: '',//视频链接
				pic: '',//视频预览图
			}
		}
	},
	components: {
		'vue-dplayer': VueDPlayer
	},
	create() {

	},
	methods: {
		playHappened() {

		}
	}
}
</script>
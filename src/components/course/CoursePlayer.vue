<template>
	<div class="config-wrap wrap-player">
		<!-- <vue-dplayer class="course-player" :video="video" :contextmenu="menu" style="overflow: auto;"></vue-dplayer> -->
		<!-- <canvas-video :src="src" :controls="true" :showVideo="true" :playPauseOnClick="true"></canvas-video> -->
		<video-player :video="video"></video-player>
	</div>
</template>

<style>
	.wrap-player {
		padding: 8px;
		width: 100%;
		height: auto;
	}
</style>

<script>
import VueDPlayer from 'vue-dplayer'
import Pic from '@/assets/be.jpg'
import VideoPlayer from './VideoPlayer'
import Storage from '@/common/util/storage'

export default {
	name: 'CoursePlayer',
	data () {
		return {
			video: {
				// url: '',//视频链接
				// pic: Pic,//视频预览图
				src: 'http://localhost:8080/TestServer/video.mp4'
			},
			menu: [],
			src: '/media/jason/application/迅雷下载/[迅雷下载www.2tu.cc]秒速5厘米.BD1024高清日语中字.mkv'
		}
	},
	components: {
		'vue-dplayer': VueDPlayer,
		VideoPlayer
	},
	create () {
		this.video.url = sessionStorage.getItem(Storage.videourl) || ''
		this.video.pic = sessionStorage.getItem(Storage.videopic) || Pic
	},
	methods: {
		playHappened () {

		}
	}
}
</script>
<template>
	<div class="wrap">
		<img :src="img" class="wrap-img">
		<p class="wrap-p">页面找不到啦~你可以</p>
		<div class="wrap-buttons">
			<span class="wrap-button back" @click="backward">返回</span>
			<router-link class="wrap-button home" to="/home/forum/forum-news" replace>首页</router-link>
		</div>
	</div>
</template>

<style scoped>
	.wrap {
		width: 100%;
		margin: 0;
		padding: 0;
	}

	.wrap-img {
		display: block;
	  margin: 12px 0;
	  padding: 0;
		width: 100%;
		height: auto;
		box-shadow: 0px 1px 4px #AAAAAA;
	}

	.wrap-p {
		margin: 24px 0 12px 0;
		width: 100%;
		text-align: center;
		color: #999999;
	}

	.wrap-buttons {
		display: flex;
		align-items: center;
		justify-content: center;
		margin: 0;
		padding: 0;
	}

	.wrap-button {
		display: inline-block;
		margin: 0 8px;
		padding: 8px 24px;
		box-shadow: 0px 1px 4px #BBBBBB;
		border-radius: 8px;
	}

	.back {
		background-color: #FFFFFF;
		color: #AAAAAA;
		border: 1px solid #AAAAAA;
	}

	.home {
		background-color: #2276FF;
		color: #FFFFFF;
	}
</style>

<script>
import Img from '@/assets/notfound.jpg'

export default {
  name: 'PageNotFound',
  data() {
  	return {
  		img: Img
  	}
  },
  methods: {
  	backward() {
  		this.$router.back()
  	}
  }
}
</script>
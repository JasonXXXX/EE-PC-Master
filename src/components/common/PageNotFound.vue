<template>
	<div class="wrap">
		<img :src="img" class="wrap-img">
		<p class="wrap-p">{{$common.strings.common_page_notfound}}</p>
		<div class="wrap-buttons">
			<el-button class="wrap-button" icon="arrow-left" @click="goback">{{$common.strings.common_button_back}}</el-button>
			<el-button class="wrap-button" type="primary" icon="menu" @click="gohome">{{$common.strings.common_button_home}}</el-button>
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
import Img from '@/assets/page-not-found.png'

export default {
	name: 'PageNotFound',
	data () {
		return {
			img: Img
		}
	},
	methods: {
		goback () {
			this.$router.back()
		},
		gohome () {
			this.$router.replace('/')
		}
	}
}
</script>
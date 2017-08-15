<template>
	<div class="config-wrap">
		<el-collapse class="wrap-collapse" v-model="activeName" accordion>
			<el-collapse-item class="wrap-collapse-item" :title="$common.strings.detail_base_info" name="base">
				<el-input :placeholder="$common.strings.detail_placeholder_name" icon="information" :autofocus="true" v-model="name">
				</el-input>
				<el-input :placeholder="$common.strings.detail_placeholder_tel" icon="warning" v-model="tel">
				</el-input>
				<el-autocomplete class="wrap-autocom" :placeholder="$common.strings.detail_placeholder_gender" :fetch-suggestions="queryGenderSuggestions" icon="minus" @select="handleGenderSelect" v-model="gender">
				</el-autocomplete>
				<el-input :placeholder="$common.strings.detail_placeholder_address" icon="menu" :autosize="{ minRows: 1, maxRows: 3}" v-model="address">
				</el-input>
				<el-input :placeholder="$common.strings.detail_placeholder_ID" icon="more" v-model="ID">
				</el-input>
				<el-input v-if="user.user===2" :placeholder="$common.strings.detail_placeholder_parentname" icon="information" v-model="parentname">
				</el-input>
				<el-input :placeholder="$common.strings.detail_placeholder_intro" icon="menu" :autosize="{ minRows: 1, maxRows: 3}" v-model="intro">
				</el-input>
				<el-input v-if="user.user===2" :placeholder="$common.strings.detail_placeholder_parenttel" icon="warning" v-model="parenttel">
				</el-input>
			</el-collapse-item>
			<el-collapse-item class="wrap-collapse-item" :title="$common.strings.detail_site_info" name="site">
				<el-autocomplete class="wrap-autocom" :placeholder="$common.strings.detail_placeholder_sub" :fetch-suggestions="querySubSuggestions" icon="document" @select="handleSubSelect" v-model="sub">
				</el-autocomplete>
				<el-autocomplete class="wrap-autocom" :placeholder="$common.strings.detail_placeholder_grade" :fetch-suggestions="queryGradeSuggestions" icon="document" @select="handleGradeSelect" v-model="grade">
				</el-autocomplete>
			</el-collapse-item>
		</el-collapse>
		<div class="wrap-upload">
			<el-upload v-if="!headimgs.length" class="upload-demo" drag ref="upload" name="headimg" :action="$common.api.UpdateHeadimg" :file-list="headimgs" :data="payload" :auto-upload="false" :on-change="handleChange">
				<i class="el-icon-upload wrap-upload-icon"></i>
				<div class="el-upload__text">{{$common.strings.detail_upload_drag_hint}}
					<em>{{$common.strings.detail_upload_click_text}}</em>
				</div>
				<div class="el-upload__tip" slot="tip">{{$common.strings.detail_upload_limit}}</div>
			</el-upload>
			<img class="wrap-upload-headimg" :src="headimg" v-if="headimgs.length">
			<el-button class="wrap-submit" slot="trigger" size="medium" type="primary" v-if="headimgs.length" @click="handleSubmit">{{$common.strings.detail_upload_submit}}</el-button>
		</div>
	</div>
</template>

<style scoped>
	.wrap-collapse {
		flex: 1;
	}
	
	.wrap-collapse-item {
		text-align: left;
	}
	
	.wrap-autocom {
		width: 100%;
	}
	
	.wrap-upload {
		margin: 12px;
	}
	
	.wrap-upload-icon {
		overflow: hidden;
	}
	
	.wrap-submit {
		margin-top: 12px;
	}
	
	.wrap-upload-headimg {
		display: block;
		width: 160px;
		height: 160px;
		margin: 12px;
		padding: 12px 24px;
		border: .5px dashed #AAAAAA;
	}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import Convert from '@/common/util/convert.js'
import Storage from '@/common/util/storage'
import ImageUtil from '@/common/util/image'

export default {
	data () {
		return {
			activeName: 'base',
			headimg: '',
			name: '',
			tel: '189****2356',
			address: 'xx省xx区xx市',
			ID: '44xxxxxxxxxxxxxxx8',
			parentname: 'xxx',
			parenttel: '135****8954',
			intro: '',
			ifModified: false,
			grade: '高二',
			sub: '英语',
			gender: '男',
			genderSuggestions: [
				{ value: this.$common.strings.common_male },
				{ value: this.$common.strings.common_female }
			],
			gradeSuggestions: [
				{ "value": this.$common.strings.common_grade_1 },
				{ "value": this.$common.strings.common_grade_2 },
				{ "value": this.$common.strings.common_grade_3 },
				{ "value": this.$common.strings.common_grade_4 },
				{ "value": this.$common.strings.common_grade_5 },
				{ "value": this.$common.strings.common_grade_6 },
				{ "value": this.$common.strings.common_grade_7 },
				{ "value": this.$common.strings.common_grade_8 },
				{ "value": this.$common.strings.common_grade_9 },
				{ "value": this.$common.strings.common_grade_10 },
				{ "value": this.$common.strings.common_grade_11 },
				{ "value": this.$common.strings.common_grade_12 },
			],
			subSuggestions: [
				{ "value": this.$common.strings.common_sub_chinese },
				{ "value": this.$common.strings.common_sub_math },
				{ "value": this.$common.strings.common_sub_english },
				{ "value": this.$common.strings.common_sub_physical },
				{ "value": this.$common.strings.common_sub_chemistry },
				{ "value": this.$common.strings.common_sub_biology },
				{ "value": this.$common.strings.common_sub_political },
				{ "value": this.$common.strings.common_sub_history },
				{ "value": this.$common.strings.common_sub_geology },
			],
			uploadURL: '',
			headimgs: [],
			payload: {}
		}
	},
	created () {
		this.payload = {
			'user': this.user.user,
			'userid': this.user.userid
		}

		this.headimg = this.user.headimg
		this.intro = this.user.intro
		this.name = this.user.name

		let params = new URLSearchParams()
		params.append('studentid', this.user.userid)
		this.$common.http.post(this.$common.api.UserInfo, params)
			.then(response => {
				this.tel = response.data.tel
				this.address = response.data.address
				this.ID = response.data.ID
				this.parentname = response.data.parentname
				this.parenttel = response.data.parenttel
				this.grade = Convert.convertGradeNumber(response.data.grade)
				this.sub = Convert.convertSubNumber(response.data.sub)
				this.gender = response.data.gender
			}).catch(error => {

			})
	},
	beforeRouteLeave (to, from, next) {
		if (this.ifModified) {
			let params = new URLSearchParams()

			params.append('user', this.user.user)
			params.append('userid', this.user.userid)
			params.append('name', this.name)
			params.append('tel', this.tel)
			params.append('gender', this.gender)
			params.append('address', this.address)
			params.append('intro', this.intro)
			params.append('grademark', Convert.convertMark(this.grademark))
			params.append('submark', Convert.convertMark(this.submark))
			params.append('parenttel', this.parenttel)
			params.append('parentname', this.parentname)
			params.append('ID', this.ID)
			params.append('token', this.user.token)

			this.$common.http.post(this.$common.api.InfoUpdate, params)
				.then(response => {
					localStorage.setItem(Storage.name, this.name)
					localStorage.setItem(Storage.intro, this.intro)
					this.$store.commit(types.UPDATE_USER_NAME_AND_INTRO, {
						name: this.name,
						intro: this.intro
					})
					this.$message({
						type: 'success',
						message: $common.strings.detail_after_save
					})
					next()
				}).catch(error => {
					this.$confirm($common.strings.detail_leave_without_save, $common.strings.dialog_warning_type, {
						confirmButtonText: $common.strings.dialog_button_yes,
						cancelButtonText: $common.strings.dialog_button_no,
						type: 'warning'
					}).then(() => {
						//保存失败,再次进行保存
						this.$common.http.post(this.$common.api.InfoUpdate, params)
							.then(response => {
								localStorage.setItem(Storage.name, this.name)
								localStorage.setItem(Storage.intro, this.intro)
								this.$store.commit(types.UPDATE_USER_NAME_AND_INTRO, {
									name: this.name,
									intro: this.intro
								})

								this.$message({
									type: 'success',
									message: $common.strings.detail_after_save
								})
								next()
							}).catch(error => {
								this.$message({
									type: 'success',
									message: $common.strings.detail_fail_and_leave
								})
								next()
							})
					}).catch(() => {
						//保存失败. 用户选择直接放弃
						next()
					})
				})
		} else {
			next()
		}
	},
	methods: {
		queryGenderSuggestions (queryString, cb) {
			const suggestions = this.genderSuggestions
			const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
			// 调用 callback 返回建议列表的数据
			cb(results)
		},
		querySubSuggestions (queryString, cb) {
			const suggestions = this.subSuggestions
			const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
			// 调用 callback 返回建议列表的数据
			cb(results)
		},
		queryGradeSuggestions (queryString, cb) {
			const suggestions = this.gradeSuggestions
			const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
			// 调用 callback 返回建议列表的数据
			cb(results)
		},
		handleGenderSelect (value) {
			// this.gender = value.value
		},
		handleGradeSelect (value) {
			// this.grade = value.value
		},
		handleSubSelect (value) {
			// this.sub = value.value
		},
		createFilter (queryString) {
			return suggestions => (suggestions.value.indexOf(queryString.toLowerCase()) === 0)
		},
		handleChange (file, fileList) {
			this.headimgs.push(file)
			ImageUtil.convertImageToBase64(this.headimgs[0]).then(result => {
				this.headimg = result
			}).catch(error => {

			})
		},
		handleSubmit () {
			// this.$refs.upload.submit()
			let params = new URLSearchParams()

			params.append('user', this.user.user)
			params.append('userid', this.user.userid)
			params.append('headimg', this.headimg)

			this.$common.http.post(this.$common.api.UpdateHeadimg, params)
				.then(response => {
					this.$message({
						type: 'success',
						message: this.$common.strings.detail_after_headimg_save
					})
					this.$store.commit(types.UPDATE_USER_HEADIMG, this.headimg)
					localStorage.setItem(Storage.headimg, this.headimg)
				}).catch(error => {
					this.$message({
						type: 'warning',
						message: this.$common.strings.detail_after_headimg_save_fail
					})
				})
		},
		backward () {
			if (this.ifModified) {
				MessageBox.confirm('返回将丢失修改的内容。是否返回？').then(action => {
					this.$router.back()
				})
			} else {
				this.$router.back()
			}
		},
		modifyName () {
			MessageBox.prompt('请输入姓名:').then(({ value, action }) => {
				this.name = value
				this.ifModified = true
			})
		},
		modifyTel () {
			MessageBox.prompt('请输入手机号:').then(({ value, action }) => {
				if (/1[0-9]{10}/.test(value)) {
					this.tel = value
					this.ifModified = true
				} else {
					Toast({
						message: '请输入正确的手机号',
						position: 'bottom',
						duration: 2000
					})
				}
			})
		},
		modify () {
			let params = new URLSearchParams()

			params.append('user', this.user.user)
			params.append('userid', this.user.userid)
			params.append('name', this.name)
			params.append('tel', this.tel)
			params.append('gender', this.gender)
			params.append('address', this.address)
			params.append('intro', this.intro)
			params.append('grademark', Convert.convertMark(this.grademark))
			params.append('submark', Convert.convertMark(this.submark))
			params.append('parenttel', this.parenttel)
			params.append('parentname', this.parentname)
			params.append('ID', this.ID)
			params.append('token', this.user.token)

			this.$common.http.post(this.$common.api.InfoUpdate, params)
				.then(response => {
					localStorage.setItem(Storage.name, this.name)
					localStorage.setItem(Storage.intro, this.intro)
					this.$store.commit(types.UPDATE_USER_NAME_AND_INTRO, {
						name: this.name,
						intro: this.intro
					})
				}).catch(error => {

				})
		},
		markEdit () {
			this.ifModified = true
		}
	},
	filters: {
		genderFilter (value) {
			return 1 === value ? '男' : '女'
		}
	},
	computed: {
		...mapGetters([
			'user'
		])
	}
}
</script>
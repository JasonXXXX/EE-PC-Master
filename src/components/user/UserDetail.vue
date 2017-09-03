<template>
	<div class="config-wrap">
		<el-collapse class="wrap-collapse" v-model.trim="activeName" accordion>
			<el-collapse-item class="wrap-collapse-item" :title="$common.strings.detail_base_info" name="base">
				<el-input :placeholder="$common.strings.detail_placeholder_name" icon="information" :autofocus="true" @change="markEdit" v-model.trim="name">
				</el-input>
				<el-input :placeholder="$common.strings.detail_placeholder_tel" icon="warning" @change="markEdit" v-model.trim="tel">
				</el-input>
				<el-autocomplete class="wrap-autocom" :placeholder="$common.strings.detail_placeholder_gender" :fetch-suggestions="queryGenderSuggestions" icon="minus" @select="handleGenderSelect" v-model.trim="gender">
				</el-autocomplete>
				<el-input :placeholder="$common.strings.detail_placeholder_address" icon="menu" :autosize="{ minRows: 1, maxRows: 3}" @change="markEdit" v-model.trim="address">
				</el-input>
				<el-input :placeholder="$common.strings.detail_placeholder_ID" icon="more" @change="markEdit" v-model.trim="ID">
				</el-input>
				<el-input v-if="user.user===2" :placeholder="$common.strings.detail_placeholder_parentname" icon="information" @change="markEdit" v-model.trim="parentname">
				</el-input>
				<el-input :placeholder="$common.strings.detail_placeholder_intro" icon="menu" :autosize="{ minRows: 1, maxRows: 3}" @change="markEdit" v-model.trim="intro">
				</el-input>
				<el-input v-if="user.user===2" :placeholder="$common.strings.detail_placeholder_parenttel" icon="warning" @change="markEdit" v-model.trim="parenttel">
				</el-input>
			</el-collapse-item>
			<el-collapse-item class="wrap-collapse-item" :title="$common.strings.detail_site_info" name="site">
				<el-autocomplete class="wrap-autocom" :placeholder="$common.strings.detail_placeholder_sub" :fetch-suggestions="querySubSuggestions" icon="document" @select="handleSubSelect" v-model.trim="sub">
				</el-autocomplete>
				<el-autocomplete class="wrap-autocom" :placeholder="$common.strings.detail_placeholder_grade" :fetch-suggestions="queryGradeSuggestions" icon="document" @select="handleGradeSelect" v-model.trim="grade">
				</el-autocomplete>
			</el-collapse-item>
		</el-collapse>
		<div class="wrap-upload">
			<img class="wrap-upload-headimg" :src="headimg">
			<div v-if="!selected">
				<el-button class="wrap-submit" slot="trigger" size="medium" v-if="!selected" @click="selectImage">修改头像
					<i class="el-icon-edit el-icon--right"></i>
				</el-button>
				<input type="file" id="inputer" accept="image/png,image/jpg,image/jpeg" ref="inputer" hidden @change="handleChange">
				<p class="wrap-hint">{{$common.strings.detail_upload_limit}}</p>
			</div>
			<el-button class="wrap-submit" slot="trigger" size="medium" v-if="selected" @click="handleCancle">取消</el-button>
			<el-button class="wrap-submit" slot="trigger" size="medium" type="primary" v-if="selected" @click="handleSubmit">{{$common.strings.detail_upload_submit}}</el-button>
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
	padding: 12px;
}

.wrap-upload-icon {
	overflow: hidden;
}

.wrap-hint {
	color: #BBBBBB;
	font-size: 12px;
}

.wrap-submit {
	margin-top: 12px;
}

.wrap-upload-headimg {
	display: block;
	width: 160px;
	height: 160px;
	margin: 12px auto;
	padding: 12px 24px;
	/*border: .5px dashed #AAAAAA;*/
	box-shadow: 1px 1px 32px #AAAAAA;
}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import Convert from '@/common/util/convert.js'
import Storage from '@/common/util/storage'
import ImageUtil from '@/common/util/image'

export default {
	data() {
		return {
			activeName: 'base',
			headimg: '',
			name: '',
			tel: '',
			address: '',
			ID: '',
			parentname: '',
			parenttel: '',
			intro: '',
			ifModified: false,
			grade: '',
			sub: '',
			gender: '',
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
			selected: false,
			payload: {}
		}
	},
	created() {
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
				this.gender = Convert.convertGender(response.data.gender)
			}).catch(error => {

			})
	},
	mounted() {
		// 单独获取头像
	},
	beforeRouteLeave(to, from, next) {
		if (this.ifModified) {
			let params = new URLSearchParams()

			params.append('user', this.user.user)
			params.append('userid', this.user.userid)
			params.append('name', this.name)
			params.append('tel', this.tel)
			params.append('gender', Convert.convertMark(this.gender))
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
						message: this.$common.strings.detail_after_save
					})
					next()
				}).catch(error => {
					this.$confirm(this.$common.strings.detail_leave_without_save, this.$common.strings.dialog_warning_type, {
						confirmButtonText: this.$common.strings.dialog_button_yes,
						cancelButtonText: this.$common.strings.dialog_button_no,
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
									message: this.$common.strings.detail_after_save
								})
								next()
							}).catch(error => {
								this.$message({
									type: 'success',
									message: this.$common.strings.detail_fail_and_leave
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
		queryGenderSuggestions(queryString, cb) {
			const suggestions = this.genderSuggestions
			const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
			// 调用 callback 返回建议列表的数据
			cb(results)
		},
		querySubSuggestions(queryString, cb) {
			const suggestions = this.subSuggestions
			const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
			// 调用 callback 返回建议列表的数据
			cb(results)
		},
		queryGradeSuggestions(queryString, cb) {
			const suggestions = this.gradeSuggestions
			const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
			// 调用 callback 返回建议列表的数据
			cb(results)
		},
		handleGenderSelect(value) {
			this.markEdit()
		},
		handleGradeSelect(value) {
			this.markEdit()
		},
		handleSubSelect(value) {
			this.markEdit()
		},
		createFilter(queryString) {
			return suggestions => (suggestions.value.indexOf(queryString.toLowerCase()) === 0)
		},
		selectImage() {
			this.$refs.inputer.click()
		},
		handleChange() {
			this.selected = true
			this.headimg = this.$refs.inputer.files[0]
			ImageUtil.convertImageToBase64(this.headimg).then(result => {
				this.headimg = result
			}).catch(error => {
				console.log(error)
			})
		},
		handleSubmit() {
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
		handleCancle() {
			this.selected = false
			this.headimg = this.user.headimg
		},
		modify() {
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
		markEdit() {
			this.ifModified = true
		}
	},
	filters: {
		genderFilter(value) {
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

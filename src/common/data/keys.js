import Storage from '@/common/util/storage'

export default {
  AppInfo: {
    APPKEY: 'x18ywvqfxjpsc',
    DESKEY: 'gyhqjxrlchzx666',
    // RONGYUNTOKEN: localStorage.getItem('rongyuntoken') || 'lixE4MxAaB91RNtNRiZe2CflBnG4WMkouAH8yc84fFRmoMsPDoowKR2E7Bp7I8E+zyrnRQpIRUAH8gCDsgrE6Q==',
    RONGYUNTOKEN: localStorage.getItem('rongyuntoken') || 'fhNUEiuI+h40zZrLo6sYkSflBnG4WMkouAH8yc84fFRmoMsPDoowKTDzQmir3HWF70E7juZyjacH8gCDsgrE6Q==',
  },
  Qiniu: {
    AccessKey: 'YDJiRV195Uq_c-1x0RiS1ENzvdEUorLcqhdSNxlf',
    SecretKey: 'ulquHZtSkIPBxyAAp9IwRjVXtnL0eEpQvImDJoww',
    uptoken: this.AccessKey + ':' + this.SecretKey + ':' + this.bucket_name,
    bucket_name: 'jason-scnu',
    bucket_domain: 'ouopd24ye.bkt.clouddn.com'
  }
}
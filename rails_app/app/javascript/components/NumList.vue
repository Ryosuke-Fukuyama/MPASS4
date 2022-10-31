<template>
  <div>
    <li v-for="health_interview in classificationHealthInterviews" :key="health_interview.id">
      {{ health_interview.guide_status.id }}
      <!-- v-model.lazy="select-status"  -->
      <select @change="selectStatus(health_interview, $event)">
        <option disabled value="">{{ health_interview.guide_status.status }}</option>
        <!-- <option v-for="status in statuses"></option> -->
        <option value="initial">初期</option>
        <option value="calling">呼出</option>
        <option value="2">決済</option>
        <option value="pending">保留</option>
        <option value="4">無断キャンセル</option>
        <option value="5">完了</option>
      </select>
      <div class="modal__button" v-if="modalFlag && (missId === health_interview.id)">
        <ErrorModal @close-click="informClick()"></ErrorModal>
      </div>
    </li>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
import ErrorModal from './ErrorModal.vue'

export default {
  name: 'NumList',
  components:{
    ErrorModal
  },

  props: {
    healthInterviews: Array,
    // basisUrl: {
    //   type: String,
    //   required: true
    // },
    modalFlag: {
      type: Boolean,
      required: true
    },
    missId: {
      // type: ,
      required: true
    },
  },

  data:() => {
    return {
      // basisUrl: this.basisUrl,
      // modalFlag: this.modalFlag,
      // missId: this.missId,
      // health_interviews: this.healthInterviews,
      classificationHealthInterviews: [],
      // statuses,
    }
  },

  watch: {
    health_interviews: {
      handler() {
        debugger
        return this.classificationHealthInterviews = this.healthInterviews
        return
      },
      immediate: true
    }
  },
  //   this.fetchContents(hospital_id, sort_status)

  // computed: {
    // params() {
    //   return {
    //     health_interview: {
    //       guide_status: {
    //         status: this.status,
    //         id:     this.id
    //       }
    //     }
    //   }
    // }
  // },

  methods: {
    // async fetchContents(hospital_id, sort_status) {
    //   const res_index = await axios.get(`/hospitals/${hospital_id}/health_interviews.json`, { params: { sort_status: sort_status }})
    //     .then((res) => {
    //       this.health_interviews = res.data.health_interviews
    //     })
    // },

    selectStatus(health_interview, e) {
      health_interview.guide_status.status = e.target.value
      const hospital_id = health_interview.hospital_id
      const id = health_interview.id
      const url = `/hospitals/${hospital_id}/health_interviews/${id}`
      axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
      axios.patch(url, health_interview)
        .then(res => {
          this.$emit('select-status')
        })
        .catch((err) => {
          this.selectStatus = ""
          const id = JSON.parse(err.config.data).id
          this.openModal(id)
          // this.$emit('select-status-err')
        })
    },

     openModal(id) {
      this.modalFlag = true
      this.missId = id
    },


    informClick() {
      this.$emit('inform-click')
    }
  }
}
</script>

<style>
  .modal__button {
  display:inline-flex;
  }
</style>

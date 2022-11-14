<template>
  <ul>
    <div class="payment__list">
      <p>{{ message.payment }}</p>
      <div v-if="healthInterviews4.length">
        <NumList
          v-if="reRendering"
          :health-interviews="healthInterviews4"
          :session-check="sessionCheck"
          :modal-flag="modalFlag"
          :miss-id="missId"
          @link-to-health_interview="locationHref"
          @success-update="renewalList"
          @failure-update="openModal"
          @inform-click="closeModal"
        ></NumList>
      </div>
    </div>
    <hr class="red__line">
    <div class="noshow__list">
      <p>{{ message.noshow }}</p>
      <div v-if="healthInterviews3.length">
        <NumList
          v-if="reRendering"
          :health-interviews="healthInterviews3"
          :session-check="sessionCheck"
          :modal-flag="modalFlag"
          :miss-id="missId"
          @link-to-health_interview="locationHref"
          @success-update="renewalList"
          @failure-update="openModal"
          @inform-click="closeModal"
        ></NumList>
      </div>
    </div>
  </ul>
</template>

<script>
import axios from 'axios'
// import { csrfToken } from 'rails-ujs'
import NumList from './components/NumList.vue'

export default {
  name: 'ReverseListSet',
  components:{
    NumList
  },

  props: {
    hospital_id: {
      // type: ,
      required: true
    }
  },

  data:() => {
    return {
      message: {
        payment: "決済中",
        noshow: "無断キャンセル"
      },
      healthInterviews4: [],
      healthInterviews3: [],
      sessionCheck: false,
      modalFlag: false,
      missId: '',
      reRendering: true
    }
  },

  created() {
    this.fetchArray(this.hospital_id)
    this.staffSignIn(this.hospital_id)
  },

  methods: {
    async fetchArray(hospital_id) {
      const res_index = await axios.get(`/hospitals/${hospital_id}/health_interviews/reverse.json`)
        .then((res) => {
          this.healthInterviews4 = res.data.health_interviews_4
          this.healthInterviews3 = res.data.health_interviews_3
         this.toggle()
        })
    },

    toggle() {
      this.reRendering = false
      this.$nextTick(() => (this.reRendering = true))
    },

    async staffSignIn(hospital_id) {
      await axios.get(`/hospitals/${hospital_id}/health_interviews/reverse.json`)
        .then((res) => {
          this.sessionCheck = res.data.session_check
        })
    },

    locationHref(health_interview) {
      const hospital_id = health_interview.hospital_id
      const id = health_interview.id
      location = `/hospitals/${hospital_id}/health_interviews/${id}`
    },

    renewalList() {
      this.fetchArray(this.hospital_id)
    },

    openModal(id) {
      this.modalFlag = true
      this.missId = id
    },

    closeModal() {
      this.modalFlag = false
      // this. = ""  実値に戻したい
    }
  }
}
</script>

<style>
.noshow__list {
  color: red;
}
</style>

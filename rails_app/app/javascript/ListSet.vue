<template>
  <ul>
    <div class="calling__list">
      <p>{{ message.calling }}</p>
      <div v-if="healthInterviews1.length">
        <NumList
          v-if="reRendering"
          :health-interviews="healthInterviews1"
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
    <hr class="sky__line">
    <div class="initial__list">
      <div v-if="healthInterviews0.length">
        <NumList
          v-if="reRendering"
          :health-interviews="healthInterviews0"
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
    <hr class="orange__line">
    <div class="pending__list">
      <p>{{ message.pending }}</p>
      <div v-if="healthInterviews2.length">
        <NumList
          v-if="reRendering"
          :health-interviews="healthInterviews2"
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
  name: 'ListSet',
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
        calling: "お呼び出し中",
        pending: "保留中"
      },
      healthInterviews1: [],
      healthInterviews0: [],
      healthInterviews2: [],
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
      const res_index = await axios.get(`/hospitals/${hospital_id}/health_interviews.json`)
        .then((res) => {
          this.healthInterviews1 = res.data.health_interviews_1
          this.healthInterviews0 = res.data.health_interviews_0
          this.healthInterviews2 = res.data.health_interviews_2
         this.toggle()
        })
    },

    toggle() {
      this.reRendering = false
      this.$nextTick(() => (this.reRendering = true))
    },

    async staffSignIn(hospital_id) {
      await axios.get(`/hospitals/${hospital_id}/health_interviews.json`)
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

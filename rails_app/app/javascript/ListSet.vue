<template>
  <ul>
    <div class="calling__list">
      <p>{{ message.calling }}</p>
      <div v-if="health_interviews_1.length === true">
        <p>検証</p>
        <NumList
          :modal-flag="modalFlag"
          :miss-id="missId"
          sort-status="calling"
          :health-interviews-1="health_interviews_1"
          @select-status="updateStatus"
          @inform-click="closeModal"
        ></NumList>
      </div>
    </div>
    <hr>
    <div class="initial__list">
      <div v-if="health_interviews_0.length === true">
        <p>検証</p>
        <NumList
          :modal-flag="modalFlag"
          :miss-id="missId"
          :sort-status="initial"
          :health-interviews-0="health_interviews_0"
          @select-status="updateStatus"
          @close-click="closeModal"
        ></NumList>
      </div>
    </div>
    <hr>
    <div class="pending__list">
      <p>{{ message.pending }}</p>
      <div v-if="health_interviews_3.length === true">
        <p>検証</p>
        <NumList
          :modal-flag="modalFlag"
          :miss-id="missId"
          :sort-status="pending"
          :health-interviews-3="health_interviews_3"
          @select-status="updateStatus"
          @close-click="closeModal"
        ></NumList>
      </div>
    </div>
  </ul>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
import NumList from './components/NumList.vue'

// Vue.component('NumList', NumList)

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
      // transmissionDate: {
        // hospital_id: this.hospital_id,
        modalFlag: false,
        missId: "",
      // },
      sortStatus: "",
      health_interviews_1: [],
      health_interviews_0: [],
      health_interviews_3: [],
      message: {
        calling: "お呼び出し中",
        pending: "保留中"
      },
      selectStatus: "",
      id: ''
    }
  },

  // created() {
  // },

  mounted() {
    this.fetchArray(this.hospital_id)
  },

  // computed: {
  // },

  methods: {
    async fetchArray(hospital_id) {
      const res_index = await axios.get(`/hospitals/${hospital_id}/health_interviews.json`)
        .then((res) => {
          debugger
          this.health_interviews_1 = res.data.health_interviews_1
          this.health_interviews_0 = res.data.health_interviews_0
          this.health_interviews_3 = res.data.health_interviews_3
        })
    },

    updateStatus(health_interview, e) {
      debugger
      // const health_interview = value.health_interview
      // const e = value.e
      health_interview.guide_status.status = e.target.value
      const hospital_id = health_interview.hospital_id
      const id = health_interview.id
      const url = `/hospitals/${hospital_id}/health_interviews/${id}`
      axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
      axios.patch(url, health_interview)
        .then(res => {
          this.fetchArray()
        })
        .catch((err) => {
          this.selectStatus = ""
          const id = JSON.parse(err.config.data).id
          this.openModal(id)
        })
    },

    openModal(id) {
      this.modalFlag = true
      this.missId = id
    },

    closeModal() {
      this.modalFlag = false
      this.selectStatus = ""
    }
  }
}
</script>

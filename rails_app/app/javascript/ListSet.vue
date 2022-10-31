<template>
  <ul>
    <div class="calling__list">
      <p>{{ message.calling }}</p>
      <div v-if="health_interviews_1.length">
        <NumList
          :health-interviews="health_interviews_1"
          :modal-flag="modalFlag"
          :miss-id="missId"
          @select-status="updateStatus"
          @inform-click="closeModal"
        ></NumList>
      </div>
    </div>
    <hr>
    <div class="initial__list">
      <div v-if="health_interviews_0.length">
        <NumList
          :health-interviews="health_interviews_0"
          :modal-flag="modalFlag"
          :miss-id="missId"
          @select-status="updateStatus"
          @close-click="closeModal"
        ></NumList>
      </div>
    </div>
    <hr>
    <div class="pending__list">
      <p>{{ message.pending }}</p>
      <div v-if="health_interviews_2.length">
        <NumList
          :health-interviews="health_interviews_2"
          :modal-flag="modalFlag"
          :miss-id="missId"
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
      health_interviews_1: [],
      health_interviews_0: [],
      health_interviews_2: [],
      modalFlag: false,
      missId: "",
      message: {
        calling: "お呼び出し中",
        pending: "保留中"
      },
      id: ''
    }
  },

  created() {
    this.fetchArray(this.hospital_id)
  },

  methods: {
    async fetchArray(hospital_id) {
      const res_index = await axios.get(`/hospitals/${hospital_id}/health_interviews.json`)
        .then((res) => {
          this.health_interviews_1 = res.data.health_interviews_1
          this.health_interviews_0 = res.data.health_interviews_0
          this.health_interviews_2 = res.data.health_interviews_2
          // this.selected = ""
        })
    },

    updateStatus() {
      this.fetchArray()
    },

    closeModal() {
      this.modalFlag = false
      this.selectStatus = ""
    }
  }
}
</script>

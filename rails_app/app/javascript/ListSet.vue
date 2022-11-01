<template>
  <ul>
    <div class="calling__list">
      <p>{{ message.calling }}</p>
      <div v-if="health_interviews_1.length">
        <NumList
          v-if="reRendering"
          :health-interviews="health_interviews_1"
          :modal-flag="modalFlag"
          :miss-id="missId"
          @success-update="renewalList"
          @failure-update="openModal"
          @inform-click="closeModal"
        ></NumList>
      </div>
    </div>
    <hr>
    <div class="initial__list">
      <div v-if="health_interviews_0.length">
        <NumList
          v-if="reRendering"
          :health-interviews="health_interviews_0"
          :modal-flag="modalFlag"
          :miss-id="missId"
          @success-update="renewalList"
          @failure-update="openModal"
          @inform-click="closeModal"
        ></NumList>
      </div>
    </div>
    <hr>
    <div class="pending__list">
      <p>{{ message.pending }}</p>
      <div v-if="health_interviews_2.length">
        <NumList
          v-if="reRendering"
          :health-interviews="health_interviews_2"
          :modal-flag="modalFlag"
          :miss-id="missId"
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
import { csrfToken } from 'rails-ujs'
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
      health_interviews_1: [],
      health_interviews_0: [],
      health_interviews_2: [],
      modalFlag: false,
      missId: '',
      reRendering: true
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
         this.toggle()
        })
    },

    toggle() {
      this.reRendering = false
      this.$nextTick(() => (this.reRendering = true))
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

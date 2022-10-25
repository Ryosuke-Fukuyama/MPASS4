<template>
  <div>
    <ul>
      <li v-for="health_interview in health_interviewList" :key="health_interview.id">
        {{ health_interview.guide_status.id }}
        <select v-model.lazy="selected" @change="contentUpdate(health_interview.id, $event)">
          <option disabled value="">{{ health_interview.guide_status.status }}</option>
          <!-- <option v-for="status in statuses"></option> -->
          <option value="0">初期</option>
          <option value="1">呼出</option>
          <option value="2">決済</option>
          <option value="3">保留</option>
          <option value="4">無断キャンセル</option>
          <option value="5">完了</option>
        </select>
        <div  v-if="modalFlag && missId==health_interview.id">
          <ErrorModal @close-click="closeModal"></ErrorModal>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios'
import ErrorModal from './ErrorModal.vue'

export default {
  components:{
    ErrorModal
  },

  props: ["sort_status"],

  data:() => {
    return {
      health_interviews: [],
      id: '',
      // statuses,
      modalFlag: false,
      missId: '',
    }
  },

  mounted() {
    this.fetchContents()
  },

  // computed: {
    // params() {
    //   return {
    //     health_interview: {
    //       guide_status: {
    //         status: this.status,
    //         // id:   this.id
    //       }
    //     }
    //   }
    // }
  // },

  methods: {
    async fetchContents() {
      debugger
      // const hospital_id = this.hospital_id
      // const sort_status = this.sort_status
      const res_index = await this.$axios.get(`/hospitals/${hospital_id}/health_interviews`, {sort_status: sort_status}).then((res) => {
        this.health_interviews = res.data.health_interviews
        this.selected = ""
      })
    },

    async contentUpdate(id, $event) {
      const hospital_id = this.hospital_id
      const url = `/hospitals/${hospital_id}/health_interviews/${id}`
      const res_data = await this.$axios.get(url)
      const patch_data = res_data.data.health_interview
      patch_data.guide_status.status = $event.target.value
      this.$axios.patch(url, patch_data)
        .then(res => {
          this.fetchContents()
        })
        .catch((err) => {
          const id = JSON.parse(err.config.data).id
          this.openModal(id)
        })
    },

    openModal(id) {
      this.modalFlag = true
      this.missId = id
    },
    closeModal(){
      this.modalFlag = false
      this.fetchContents()
    }
  }
}
</script>

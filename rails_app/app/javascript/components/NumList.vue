<template>
  <div>
    <li v-for="health_interview in healthInterviewsList" :key="health_interview.id">
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
      <div class="modal__button" v-if="modal-flag && miss-id==health_interview.id">
        <ErrorModal @close-click="closeClick()"></ErrorModal>
      </div>
    </li>
  </div>
</template>

<script>
// import axios from 'axios'
// import { csrfToken } from 'rails-ujs'
import ErrorModal from './ErrorModal.vue'

export default {
  components:{
    ErrorModal
  },

  props: {
    hospitalId: {
      // type: ,
      required: true
    },
    sortStatus: {
      type: String,
      required: true
    },
    healthInterviews1: Array,
    healthInterviews0: Array,
    healthInterviews3: Array,
    modalFlag: {
      type: Boolean,
      defaulte: false
    },
    missId: {
      // type: ,
      required: true
    }
  },

  data:() => {
    return {
      hospital_id: this.hospitalId,
      sortStatus: this.sortStatus,
      health_interviews_1: this.healthInterviews1,
      health_interviews_0: this.healthInterviews0,
      health_interviews_3: this.healthInterviews3,
      modalFlag: this.modalFlag,
      missId: this.missId,
      // statuses,
      // id: '',
      // selectStatus: '',
      health_interview: '',
      e: ''
    }
  },

  // mounted() {
  //   const sort_status = this.sort_status
  //   this.fetchContents(hospital_id, sort_status)
  // },

  computed: {
    healthInterviewsList: function() {
      if(sortStatus === "calling") return this.healthInterviews1
      if(sortStatus === "initial") return this.healthInterviews0
    return this.healthInterviews3
    }
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
  },

  methods: {
    // async fetchContents(hospital_id, sort_status) {
    //   const res_index = await axios.get(`/hospitals/${hospital_id}/health_interviews.json`, { params: { sort_status: sort_status }})
    //     .then((res) => {
    //       this.health_interviews = res.data.health_interviews
    //     })
    // },

    selectStatus(health_interview, e) {
      this.$emit('select-status', { health_interview, e })
      // this.value = { health_interview, e }
    },

    closeClick() {
      this.$emit('close-click')
    }
  }
}
</script>

<style>
  .modal__button {
  display:inline-flex;
  }
</style>

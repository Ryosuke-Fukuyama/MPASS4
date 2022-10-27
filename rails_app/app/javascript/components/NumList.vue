<template>
  <div>
    <li v-for="health_interview in health_interviews" :key="health_interview.id">
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
  </div>
</template>

<script>
import axios from 'axios'
import ErrorModal from './ErrorModal.vue'

export default {
  name: 'num-list',
  components:{
    ErrorModal
  },

  props: ['hospital_id', 'sort_status'],
  // {
  //   hospital_id: {
  //     // type: integer,
  //     default: () => JSON.parse(document.getElementById("num-list").attributes[1].value).hospital_id
  //   },
  //   sort_status: {
  //     type: String,
  //     default: () => JSON.parse(document.getElementById("num-list").attributes[1].value).sort_status
  //   }
  // },

  data:() => {
    return {
      // hospital_id: '',
      // sort_status: '',
      health_interviews: [],
      id: '',
      // statuses,
      modalFlag: false,
      missId: '',
    }
  },

  // beforeCreate() {
  // },

  // created() {
  //   let hospital_id = this.hospital_id
  //   let sort_status = this.sort_status
  // },

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
      const node = document.getElementById("num-list")
      const props = JSON.parse(node.attributes[1].value)
      let hospital_id = props.hospital_id
      let sort_status = props.sort_status
      const res_index = await axios.get(`/hospitals/${hospital_id}/health_interviews`, { params: { sort_status: sort_status} }).then((res) => {
        this.health_interviews = res.data
        debugger
        this.selected = ""
      })
    },

    async contentUpdate(id, $event) {
      // const hospital_id = this.hospital_id
      const url = `/hospitals/${hospital_id}/health_interviews/${id}`
      const res_data = await axios.get(url)
      const patch_data = res_data.data.health_interview
      patch_data.guide_status.status = $event.target.value
      axios.patch(url, patch_data)
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

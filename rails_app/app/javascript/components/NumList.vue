<template>
  <div>
    <li v-for="health_interview in classificationHealthInterviews" :key="health_interview.id">
      <div v-if="!sessionCheck">{{ health_interview.guide_status.id }}</div>

      <div v-if="sessionCheck">
        <span>
          <div @click="linkToHealthInterview(health_interview)" class="link__to">
            {{ health_interview.guide_status.id }}
          </div><select
            v-model.lazy="health_interview.guide_status.status"
            @change="selectStatus(health_interview, $event)"
          >
            <option value="initial">初期</option>
            <option value="calling">呼出</option>
            <option value="pending">保留</option>
            <option value="noshow">無断キャンセル</option>
            <option value="payment">決済</option>
          </select><div
            v-if="modalFlag && (missId === health_interview.id)"
            class="modal__button"
          >
            <ErrorModal @close-click="informClick()"></ErrorModal>
          </div>
        </span>
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
    sessionCheck: {
      type: Boolean,
      required: true
    },
    modalFlag: {
      type: Boolean,
      required: true
    },
    missId: {
      // type: ,
      required: true
    }
  },

  // data:() => {
  //   return {
  //   }
  // },

  watch: {
    health_interviews: {
      handler() {
        return this.classificationHealthInterviews = this.healthInterviews
        return
      },
      immediate: true
    }
  },

  methods: {
    linkToHealthInterview(health_interview) {
      this.$emit('link-to-health_interview', health_interview)
    },

    selectStatus(health_interview, e) {
      health_interview.guide_status.status = e.target.value
      const hospital_id = health_interview.hospital_id
      const id = health_interview.id
      const url = `/hospitals/${hospital_id}/health_interviews/${id}`
      axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
      axios.patch(url, health_interview)
        .then(res => {
          this.$emit('success-update')
        })
        .catch((err) => {
          const id = JSON.parse(err.config.data).id
          this.$emit('failure-update', id)
        })
    },

    informClick() {
      this.$emit('inform-click')
    }
  }
}
</script>

<style>
   ul,li {
    list-style: none;
  }

  span {
    display: -webkit-flex;
    display: flex;
  }

  select {
    width: 50px;
    border-radius: 15px;
  }

  .link__to {
    margin-right: 2px;
    text-decoration: underline;
  }

  .link__to:hover {
    color: blue;
  }

  /* .modal__button {
    display: inline-flex;
  } */
</style>
